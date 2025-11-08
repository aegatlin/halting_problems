"""
Interactive CogVideoX Video Generator

Generates videos from text prompts using your MPS-enabled GPU.
Supports both CogVideoX-2B (fast) and CogVideoX-5B (high quality) modes.
"""

import os

# Enable MPS fallback for operations not supported on Apple Silicon
os.environ["PYTORCH_ENABLE_MPS_FALLBACK"] = "1"

import sys
import time
from datetime import datetime
from pathlib import Path

import torch

# Patch torch.view_as_complex to avoid float64 on MPS
_orig_view_as_complex = torch.view_as_complex


def patched_view_as_complex(tensor):
    """Wrapper to ensure complex tensors use float32 on MPS devices."""
    if tensor.device.type == "mps" and tensor.dtype == torch.float64:
        tensor = tensor.to(torch.float32)
    return _orig_view_as_complex(tensor)


torch.view_as_complex = patched_view_as_complex

# Set default dtype to float32 to avoid float64 issues on MPS
torch.set_default_dtype(torch.float32)

from diffusers import CogVideoXPipeline
from diffusers.utils import export_to_video


def get_user_choice(prompt: str, choices: list[str], default_idx: int = 0) -> str:
    """Get user input with numbered choices."""
    print(f"\n{prompt}")
    for i, choice in enumerate(choices, 1):
        default_marker = " (default)" if i - 1 == default_idx else ""
        print(f"  {i}. {choice}{default_marker}")

    while True:
        choice = input(
            f"\nEnter choice (1-{len(choices)}) or press Enter for default: "
        ).strip()

        # Default on empty input
        if not choice:
            return choices[default_idx]

        # Validate numeric choice
        try:
            idx = int(choice) - 1
            if 0 <= idx < len(choices):
                return choices[idx]
            else:
                print(f"Please enter a number between 1 and {len(choices)}")
        except ValueError:
            print("Please enter a valid number")


def generate_video(
    prompt: str,
    model_id: str,
    model_name: str,
    num_inference_steps: int,
    num_frames: int,
    guidance_scale: float = 6.0,
    output_dir: str = "videos",
) -> None:
    """Generate a video from a text prompt using the specified model."""

    # Check MPS availability - REQUIRED for video generation
    if not torch.backends.mps.is_available():
        print("\n✗ Error: MPS (Apple Silicon GPU) not available!", file=sys.stderr)
        print("CPU is too slow for video generation. Exiting.", file=sys.stderr)
        sys.exit(1)

    device = "mps"
    print("\n✓ MPS is available - using GPU acceleration!")

    # Create output directory
    output_path = Path(output_dir)
    output_path.mkdir(exist_ok=True)

    # Calculate video duration (CogVideoX runs at 8fps)
    fps = 8
    duration = num_frames / fps

    print(f"\n{'=' * 60}")
    print(f"  {model_name} Video Generation")
    print("=" * 60)
    print(f"Prompt: {prompt}")
    print(f"Device: {device}")
    print(f"Frames: {num_frames} ({duration:.1f}s @ {fps}fps)")
    print(f"Steps: {num_inference_steps}")
    print(f"Guidance: {guidance_scale}")
    print("=" * 60 + "\n")

    # Load the model
    print(f"Loading {model_name} model...")
    print("(First run will download ~8-20GB of model weights)")
    load_start = time.time()

    pipe = CogVideoXPipeline.from_pretrained(
        model_id,
        dtype=torch.float16,
    )
    pipe = pipe.to(device)
    pipe.enable_attention_slicing()  # Reduce memory and ensure float16 precision

    load_time = time.time() - load_start
    print(f"✓ Model loaded in {load_time:.2f} seconds\n")

    # Generate the video
    print("Generating video...")
    print("(This may take several minutes...)")
    gen_start = time.time()

    video_frames = pipe(
        prompt=prompt,
        num_videos_per_prompt=1,
        num_inference_steps=num_inference_steps,
        num_frames=num_frames,
        guidance_scale=guidance_scale,
        generator=torch.Generator().manual_seed(42),
    ).frames[0]

    gen_time = time.time() - gen_start

    # Save the video
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    model_prefix = "cogvideo-2b" if "2b" in model_id.lower() else "cogvideo-5b"
    filename = f"{model_prefix}_{timestamp}.mp4"
    filepath = output_path / filename

    export_to_video(video_frames, str(filepath), fps=fps)

    # Print results
    print("=" * 60)
    print("  Generation Complete!")
    print("=" * 60)
    print(f"Generation time: {gen_time:.2f} seconds ({gen_time / 60:.1f} minutes)")
    print(f"Total time: {load_time + gen_time:.2f} seconds")
    print(f"Saved to: {filepath.absolute()}")
    print("=" * 60 + "\n")


def main():
    print("=" * 60)
    print("  Interactive CogVideoX Video Generator")
    print("=" * 60)

    # Step 1: Model selection
    model_choice = get_user_choice(
        "Select model:",
        [
            "CogVideoX-2B - Fast (~8GB download, faster generation)",
            "CogVideoX-5B - High Quality (~20GB download, better results)",
        ],
        default_idx=0,
    )

    is_2b = model_choice.startswith("CogVideoX-2B")

    if is_2b:
        model_id = "THUDM/CogVideoX-2b"
        model_name = "CogVideoX-2B"
    else:
        model_id = "THUDM/CogVideoX-5b"
        model_name = "CogVideoX-5B"

    # Step 2: Quality/Steps
    steps_choice = get_user_choice(
        "Select quality (inference steps):",
        [
            "Fast - 30 steps",
            "Medium - 50 steps",
            "High - 80 steps",
        ],
        default_idx=1,
    )

    if steps_choice.startswith("Fast"):
        num_inference_steps = 30
    elif steps_choice.startswith("Medium"):
        num_inference_steps = 50
    else:
        num_inference_steps = 80

    # Step 3: Video length
    length_choice = get_user_choice(
        "Select video length:",
        [
            "Short - 3 seconds (24 frames)",
            "Long - 6 seconds (49 frames)",
        ],
        default_idx=0,
    )

    if length_choice.startswith("Short"):
        num_frames = 24
    else:
        num_frames = 49

    # Step 4: Get prompt
    print("\nEnter your video description (prompt):")
    print("(Example: 'A cat walks on the grass, realistic style')")
    prompt = input("> ").strip()

    if not prompt:
        print("\n✗ Error: Prompt cannot be empty", file=sys.stderr)
        sys.exit(1)

    # Generate the video
    try:
        generate_video(
            prompt=prompt,
            model_id=model_id,
            model_name=model_name,
            num_inference_steps=num_inference_steps,
            num_frames=num_frames,
        )
    except Exception as e:
        print(f"\n✗ Error generating video: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
