import torch
from diffusers import DiffusionPipeline

pipe = DiffusionPipeline.from_pretrained("black-forest-labs/FLUX.1-dev", torch_dtype=torch.bfloat16)

pipe.to("mps")

prompt = "Astronaut in the jungle"
image = pipe(prompt).images[0]
image.save("image.png")
