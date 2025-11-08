"""
checks for mps support.

mps, or Metal Performance Shaders is basically Apple's CUDA
"""

import platform
import sys

import torch


def print_section(title: str) -> None:
    """Print a formatted section header."""
    print(f"\n{'=' * 60}")
    print(f"  {title}")
    print("=" * 60)


def check_mps_support() -> None:
    """Check and display MPS support information."""

    print_section("System Information")
    print(f"Platform: {platform.platform()}")
    print(f"Machine: {platform.machine()}")
    print(f"Processor: {platform.processor()}")
    print(f"Python version: {sys.version.split()[0]}")

    print_section("PyTorch Information")
    print(f"PyTorch version: {torch.__version__}")
    print(f"PyTorch file location: {torch.__file__}")

    print_section("MPS Support Status")

    # Check if MPS is built
    mps_built = torch.backends.mps.is_built()
    print(f"MPS built into PyTorch: {mps_built}")

    # Check if MPS is available
    mps_available = torch.backends.mps.is_available()
    print(f"MPS available on device: {mps_available}")

    # Overall status
    print_section("Summary")
    if mps_built and mps_available:
        print("✓ MPS is FULLY SUPPORTED and ready to use!")
        print("\nYou can use MPS acceleration with:")
        print("  device = torch.device('mps')")
        print("  tensor = torch.tensor([1.0, 2.0]).to('mps')")

        # Try a simple operation
        try:
            print_section("Quick MPS Test")
            device = torch.device("mps")
            x = torch.randn(3, 3, device=device)
            y = torch.randn(3, 3, device=device)
            z = x @ y  # Matrix multiplication
            print(
                "✓ Successfully created tensors and performed operations on MPS device!"
            )
            print(f"Test tensor shape: {z.shape}")
            print(f"Test tensor device: {z.device}")
        except Exception as e:
            print(f"✗ MPS test failed: {e}")

    elif mps_built and not mps_available:
        print("⚠ MPS is built into PyTorch but NOT available on this device")
        print("\nPossible reasons:")
        print("  - Not running on Apple Silicon (M1/M2/M3/M4)")
        print("  - macOS version too old (requires macOS 12.3+)")

    elif not mps_built:
        print("✗ MPS is NOT built into this PyTorch installation")
        print("\nTo get MPS support:")
        print("  - Install PyTorch version 1.12.0 or later")
        print("  - Use the official PyTorch installation for macOS")

    else:
        print("✗ MPS support status unclear")

    print("\n" + "=" * 60 + "\n")


if __name__ == "__main__":
    try:
        check_mps_support()
    except Exception as e:
        print(f"\n✗ Error checking MPS support: {e}", file=sys.stderr)
        sys.exit(1)
