from transformers import pipeline

classifier = pipeline("sentiment-analysis", device="mps")

results = classifier("We are very happy to show you the 🤗 Transformers library.")

print(results)
