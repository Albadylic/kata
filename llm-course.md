# Hands-On AI: Build a Generative Language Model from Scratch

(link)[https://www.linkedin.com/learning-login/share?account=67552986&forceAccount=false&redirect=https%3A%2F%2Fwww.linkedin.com%2Flearning%2Fhands-on-ai-build-a-generative-language-model-from-scratch%3Ftrk%3Dshare_ent_url%26shareId%3DXM9gyEANQwedYyGyFUuhFA%253D%253D]

Building an llm to come up with the next word in a sentence.

Chart to map words to possibilities for next word.

Tokens are mapped to possibilities using a dictionary of lists (an object of arrays).

## Python methods / functions

defaultdict(list) allows building of dictionaries


enumerate() allows for indexing within a for loop, like so

```python
for i, token in enumerate(tokens)
	print(i, token)
```

import random lets us use methods of that - e.g. random.choice(tokens) will choose a random item in the list

## Markov Chain

> A Markov chain or Markov process is a stochastic model describing a sequence of possible events in which the probability of each event depends only on the state attained in the previous event. Informally, this may be thought of as, "What happens next depends only on the state of affairs now."
- Wikipedia

These are used to create strings which can reference previous tokens to predict the next token and add it to the string.

## Sentiment analysis

Analysing the feeling behind a piece of text. For example, whether it is considered positive or negative.

We create a list with a set of tuples. Each tuple countains a string and a feeling ("pos" or "neg").

We're using a 'naive Bayes Classifier' to analyse the sentiment of new strings based on data of positive and negative tokens passsed in. Our scores for the new string are determined based on the occurences of certain tokens in the predefined, analysed strings.

Checking how many positive and negative tokens lets us determine whether overall the new string would be considered positive, negative or neutral. In reality, we'd use lambda scores to determine this, for a simple version we can compare sums.