#!/usr/bin/env python3
"""
Interactive Stable Diffusion Image Generator

Generates images from text prompts using your MPS-enabled GPU.
Supports both fast (SDXL-Turbo) and slow (SDXL Base) modes.
"""

import sys
import time
from datetime import datetime
from pathlib import Path

import torch
from diffusers import AutoPipelineForText2Image, StableDiffusionXLPipeline


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


def generate_image(
    prompt: str,
    model_id: str,
    model_name: str,
    num_inference_steps: int,
    guidance_scale: float,
    width: int,
    height: int,
    output_dir: str = "images",
) -> None:
    """Generate an image from a text prompt using the specified model."""

    # Check MPS availability
    if not torch.backends.mps.is_available():
        print("\n⚠ MPS not available! Falling back to CPU (this will be slow)")
        device = "cpu"
    else:
        print("\n✓ MPS is available - using GPU acceleration!")
        device = "mps"

    # Create output directory
    output_path = Path(output_dir)
    output_path.mkdir(exist_ok=True)

    print(f"\n{'=' * 60}")
    print(f"  {model_name} Image Generation")
    print("=" * 60)
    print(f"Prompt: {prompt}")
    print(f"Device: {device}")
    print(f"Size: {width}x{height}")
    print(f"Steps: {num_inference_steps}")
    print(f"Guidance: {guidance_scale}")
    print("=" * 60 + "\n")

    # Load the model
    print(f"Loading {model_name} model...")
    load_start = time.time()

    if "turbo" in model_id.lower():
        pipe = AutoPipelineForText2Image.from_pretrained(
            model_id, torch_dtype=torch.float16, variant="fp16"
        )
    else:
        pipe = StableDiffusionXLPipeline.from_pretrained(
            model_id, torch_dtype=torch.float16, variant="fp16", use_safetensors=True
        )

    pipe = pipe.to(device)

    load_time = time.time() - load_start
    print(f"✓ Model loaded in {load_time:.2f} seconds\n")

    # Generate the image
    print("Generating image...")
    gen_start = time.time()

    image = pipe(
        prompt=prompt,
        num_inference_steps=num_inference_steps,
        guidance_scale=guidance_scale,
        width=width,
        height=height,
    ).images[0]

    gen_time = time.time() - gen_start

    # Save the image
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    mode_prefix = "fast" if "turbo" in model_id.lower() else "slow"
    filename = f"{mode_prefix}_{timestamp}.png"
    filepath = output_path / filename
    image.save(filepath)

    # Print results
    print("=" * 60)
    print("  Generation Complete!")
    print("=" * 60)
    print(f"Generation time: {gen_time:.2f} seconds")
    print(f"Total time: {load_time + gen_time:.2f} seconds")
    print(f"Saved to: {filepath.absolute()}")
    print("=" * 60 + "\n")


def main():
    print("=" * 60)
    print("  Interactive Stable Diffusion Image Generator")
    print("=" * 60)

    # Step 1: Mode selection
    mode = get_user_choice(
        "Select generation mode:",
        [
            "Fast - SDXL-Turbo (~2 sec, experimental quality)",
            "Slow - SDXL Base (better quality, ~30 sec)",
        ],
        default_idx=0,
    )

    is_fast = mode.startswith("Fast")

    # Configure based on mode
    if is_fast:
        model_id = "stabilityai/sdxl-turbo"
        model_name = "SDXL-Turbo"
        guidance_scale = 0.0

        # Step 2: Steps for fast mode
        steps_choice = get_user_choice(
            "Select number of inference steps:", ["4", "8"], default_idx=0
        )
        num_inference_steps = int(steps_choice)
    else:
        model_id = "stabilityai/stable-diffusion-xl-base-1.0"
        model_name = "SDXL Base"
        guidance_scale = 7.5

        # Step 2: Steps for slow mode
        steps_choice = get_user_choice(
            "Select number of inference steps:", ["20", "35", "50"], default_idx=0
        )
        num_inference_steps = int(steps_choice)

    # Step 3: Image size
    size_choice = get_user_choice(
        "Select image size:", ["512x512", "1024x1024"], default_idx=0
    )

    if size_choice == "512x512":
        width, height = 512, 512
    else:
        width, height = 1024, 1024

    # Step 4: Get prompt
    print("\nEnter your image description (prompt):")
    prompt = input("> ").strip()

    if not prompt:
        print("\n✗ Error: Prompt cannot be empty", file=sys.stderr)
        sys.exit(1)

    # Generate the image
    try:
        generate_image(
            prompt=prompt,
            model_id=model_id,
            model_name=model_name,
            num_inference_steps=num_inference_steps,
            guidance_scale=guidance_scale,
            width=width,
            height=height,
        )
    except Exception as e:
        print(f"\n✗ Error generating image: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
