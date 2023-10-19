import fasttext
import re
import nltk
from nltk.tokenize.toktok import ToktokTokenizer
from nltk.corpus import stopwords
import unicodedata
from emoji import demojize

def text_cleaning(text_data, stop_words, lemmatizer):
    text_data = unicodedata.normalize('NFKD', text_data).encode('ascii', 'ignore').decode('utf-8', 'ignore')
    text_data = text_data.lower()
    text_data = demojize(text_data)
    pattern_punct = re.compile(r'([.,/#!$%^&*?;:{}=_`~()+-])\1{1,}')
    text_data = pattern_punct.sub(r'\1', text_data)
    text_data = re.sub(' {2,}',' ', text_data)
    text_data = re.sub(r"[^a-zA-Z?!]+", ' ', text_data)
    text_data = str(text_data)
    tokenizer = ToktokTokenizer()
    text_data = tokenizer.tokenize(text_data)
    text_data = [item for item in text_data if item not in stop_words]
    text_data = [lemmatizer.lemmatize(word = w, pos = 'v') for w in text_data]
    text_data = ' '.join (text_data)
    return text_data

def load_shit():
    #nltk.download('stopwords')
    stop_words = set(stopwords.words('english'))
    lemmatizer = nltk.stem.WordNetLemmatizer()
    model = fasttext.load_model('NSFW Text\English\profanity_model_eng.bin')
    #nltk.download('wordnet')
    return stop_words, lemmatizer, model

def test_profanity(user_input, stop_words, lemmatizer, model):
    print("\nYou entered:", user_input)
    user_input = text_cleaning(user_input, stop_words, lemmatizer)
    labels, probabilities = model.predict(user_input, k=2)
    for label, probability in zip(labels, probabilities):
        if label[9:] == "1":
            print(f'Profane: {round(probability*100, 1)}%')
        else:
            print(f'Clean: {round(probability*100, 1)}%')

def show_embeddings(user_input, model, stop_words, lemmatizer):
    user_input = text_cleaning(user_input, stop_words, lemmatizer)
    user_input = user_input.split()
    embeddings = []
    for i in range(len(user_input)):
        embeddings = model.get_word_vector(user_input)
        print(embeddings)

def main():
    stop_words, lemmatizer, model = load_shit()
    user_input = ""
    user_input = input("Enter something: ")
    test_profanity(user_input, stop_words, lemmatizer, model)

if __name__ == "__main__":
    main()