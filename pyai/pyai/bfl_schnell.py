import torch
from diffusers import FluxPipeline

pipe = FluxPipeline.from_pretrained("black-forest-labs/FLUX.1-schnell", torch_dtype=torch.bfloat16)

pipe.to("mps")

prompt = "A cat holding a sign that says hello world"
image = pipe(
    prompt,
    num_inference_steps=4,
).images[0]

image.save("image.png")
