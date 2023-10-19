from bp import better_profanity

def profanity_check(text):
    profanity = better_profanity.Profanity()
    return profanity.contains_profanity(text)
    
def main():
    text = input("input text: ")
    out = profanity_check(text)
    print(out)

if __name__ == "__main__":
    main()