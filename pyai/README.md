# pyai

Experiments in local AI.

## Setup

On MacOS I was not able to install `sentencepiece` without also running the
following,

```sh
brew install cmake
brew install pkgconf
```

After activating the pip venv:

```sh
pip install .
```

Now you should be able to run,

```sh
python pyai/bfl_dev.py
```
