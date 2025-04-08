from diffusers import DiffusionPipeline

pipeline = DiffusionPipeline.from_pretrained("stable-diffusion-v1-5/stable-diffusion-v1-5", use_safetensors=True)

pipeline.to("mps")

image = pipeline("Realistic image of a squirrel").images[0]

image.save("image.png")
