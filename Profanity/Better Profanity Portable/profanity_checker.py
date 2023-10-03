from bp import better_profanity
import os

def profanity_check(text):
    profanity = better_profanity.Profanity()
    return profanity.contains_profanity(text)
    
def main():
    while True:
        text = input("input text: ")
        if "addtolist" in text:
            text = text.replace("addtolist ", "")
            add_to_list(text)
        out = profanity_check(text)
        print(out)

def add_to_list(text):
    current_directory = os.path.dirname(os.path.abspath(__file__))
    relative_path = os.path.join(current_directory, 'bp', 'profanity_wordlist.txt')
    with open(relative_path, "a") as file:
        text = text + "\n"
        file.write(text)
    print(f"{text}, added to wordlist")

if __name__ == "__main__":
    main()