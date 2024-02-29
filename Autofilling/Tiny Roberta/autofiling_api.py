from flask import Flask, request, jsonify
from transformers import AutoModelForQuestionAnswering, AutoTokenizer, pipeline
import re
model_name = "deepset/tinyroberta-squad2"

app = Flask(__name__)

questions = ["What is the job title?",
             "What is the company name?",
             "",
             "What is the job salary?",
             "What is the job deadline?",
             "What city is the job in?",
             "Is the job mode physical , online, hybrid?",
             "Is the job type full time, part time or contractual?",
             "Is the job for males, females or both?",
             "Years of experience required?",
             "What is the email mentioned in this job description?",
             "What is the phone number mentioned in this job description?"
            ]

questions2 = ["What is the title of the job position being advertised?",
              "Which company is offering the job? The full name of the company is required.",
              "",
              "What is the salary range or amount stated for the job?",
              "What is the application deadline for the job?",
              "Where is the job location or what is the job city mentioned in the description?",
              "Is the job described as on-site, remote, or hybrid?",
              "Is the job full-time, part-time, or contractual as mentioned in the description?",
              "Does the job specify a preferred gender, if any?",
              "How many years of experience are required for the job?",
              "What is the email mentioned in this job description?",
              "What is the phone number mentioned in this job description?"
            ]

field_dict = {  0: "job_title",
                1: "company_name",
                2: "description",
                3: "salary",
                4: "deadline",
                5: "location",
                6: "mode",
                7: "type",
                8: "sex",
                9: "experience",
                10: "email",
                11: "phone"
            }

def clean_text(text):
    # Fix encoding issues, such as 'â€™' turning into proper apostrophes
    #text = text.encode('latin1').decode('utf8').encode('ascii', 'ignore').decode('ascii')
    # Replace multiple whitespace with a single space
    text = re.sub(r'\s+', ' ', text).strip()
    return text

def validate_and_format_answer(answer, field_type):
    lower_answer = answer.lower()
    
    if field_type == 'job_title':
        pass
    
    elif field_type == 'company_name':
        pass

    elif field_type == 'description':
        pass

    elif field_type == 'salary':
        if '000' in lower_answer:
            answer = answer
        else:
            pattern1 = r'\b(?:\d{1,3}(,\d{3})*){1}(?:,?\d*)\s?-\s?(?:\d{1,3}(,\d{3})*){1}(?:,?\d*)000\b'
            pattern2 = r'\b\d{1,3}(,\d{3})*,?\d*000\b'
            pattern3 = r'(\b\d{4,}(?=[a-zA-Z])|\b\d{5,}\b)'

            match1 = re.search(pattern1, answer)
            match2 = re.search(pattern2, answer)
            match3 = re.search(pattern3, answer)

            if match1:
                print(match1.group(0))
                answer = match1.group() 
            elif match2:
                print(match2.group(0))
                answer = match2.group()
            elif match3:
                print(match3.group(0))
                answer = match3.group()
            else :
                answer = None

    elif field_type == 'deadline':
        temp = answer
        # Check for dates in the format dd/mm/yyyy
        matches = re.search(r'\b\d{1,2}/\d{1,2}/\d{4}\b', temp)
        answer = matches.group() if matches else None
        
        # If no match found in the first format, check for written dates
        if not answer:
            # Check for dates like "24th February 2024," "15 Dec," "Thirteen Jan," and "Twelve March 2024"
            written_date_matches = re.search(r'(\d{1,2}(?:st|nd|rd|th)?\s*(?:January|February|March|April|May|June|July|August|September|October|November|December|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(?:\s*(?:\d{4}|\d{2}))?)', temp, re.IGNORECASE)
            answer = written_date_matches.group(1) if written_date_matches else None
    
    elif field_type == 'location':
        if 'karachi' in lower_answer:
            answer = "Karachi"
        elif 'lahore' in lower_answer:
            answer = "Lahore"
        elif 'islamabad' in lower_answer:
            answer = "Islamabad"
        elif 'rawalpindi' in lower_answer:
            answer = "Rawalpindi"
        elif 'peshawar' in lower_answer:
            answer = "Peshawar"
        elif 'quetta' in lower_answer:
            answer = "Quetta"
        elif 'multan' in lower_answer:
            answer = "Multan"
        elif 'hyderabad' in lower_answer:
            answer = "Hyderabad"
        else:
            answer = ""
        
    elif field_type == 'mode':
        if 'hybrid' in lower_answer or (('onsite' in lower_answer or 'on-site' in lower_answer or 'physical' in lower_answer) and ('online' in lower_answer or 'remote' in lower_answer or 'work from home' in lower_answer)):
            answer = "Hybrid"
        elif 'onsite' in lower_answer or 'on-site' in lower_answer or 'physical' in lower_answer:
            answer = 'Physical'
        elif 'online' in lower_answer or 'remote' in lower_answer or 'work from home' in lower_answer:
            answer = "Remote"
        else:
            answer = None
    
    elif field_type == 'type':
        if 'fulltime' or 'full-time' or 'full time' in lower_answer: 
            answer ="Full-time"
        elif 'parttime' or 'part-time' or 'part time' in lower_answer: 
            answer = "Part-time"
        elif 'internship' in lower_answer: 
            answer = "Internship"
        elif 'contract' or "contractual" in lower_answer: 
            answer = "Contractual"
        elif 'volunteer' or 'social work' in lower_answer:
            answer ='Social Work'
        else:
            answer = None

    elif field_type == 'sex':
        if "" or "unknown" or ('male' and 'female') in lower_answer:
            answer = "No Preference"
        elif "male" in lower_answer:
            answer = "Male"
        elif "female" in lower_answer:
            answer = "Female"
        elif 'intersex' or 'inter-sex' in lower_answer:
            answer = "Intersex"
        else:
            answer = None

    elif field_type == 'experience':
        matches = re.search(r'\b\d+\s+years\b', answer, re.IGNORECASE)
        answer = matches.group() if matches else None
    
    elif field_type == 'email':
        pattern_email = r'[\w\.-]+@[\w\.-]+\.\w+'

        match_email = re.search(pattern_email, answer)

        if match_email:
            answer = match_email.group()
        else:
            answer = None
    
    elif field_type == 'phone':
        pattern_number = r'(?:(?:\+|00)92)?\s*0*3\d{2}(?:-|\s*)\d{7}'
    
        match_number = re.search(pattern_number, answer)

        if match_number:
            answer = match_number.group()
        else:
            answer = None

    return answer

def extract_fields(context):
    # Initialize the QA model pipeline
    nlp = pipeline('question-answering', model=model_name, tokenizer=model_name)
    
    # Clean up the context text
    context = clean_text(context)
    
    extracted_data = []
    for idx, question in enumerate(questions):
        if idx == 2:
            extracted_data.append(f"{context}")
        elif idx == 10:
            validated_answer = validate_and_format_answer(context, field_dict[idx])
            extracted_data.append(f"{validated_answer if validated_answer else 'Unknown'}")
        elif idx == 11:
            validated_answer = validate_and_format_answer(context, field_dict[idx])
            extracted_data.append(f"{validated_answer if validated_answer else 'Unknown'}")
        else:
            # Ask the model each question, providing the entire cleaned context
            result = nlp(question=question, context=context)
            answer = result['answer']
            
            # Validate and format the answer based on its type
            validated_answer = validate_and_format_answer(answer, field_dict[idx])
            
            # Store the answer, use 'Unknown' if validation failed
            extracted_data.append(f"{validated_answer if validated_answer else 'Unknown'}")
        
    return extracted_data

def extract_fields2(context):
    # Initialize the QA model pipeline
    nlp = pipeline('question-answering', model=model_name, tokenizer=model_name)
    
    # Clean up the context text
    context = clean_text(context)
    
    extracted_data = []
    for idx, question in enumerate(questions2):
        print(field_dict[idx])
        if idx == 2:
            extracted_data.append(f"{context}")
        elif idx == 10:
            validated_answer = validate_and_format_answer(context, field_dict[idx])
            extracted_data.append(f"{validated_answer if validated_answer else 'Unknown'}")
        elif idx == 11:
            validated_answer = validate_and_format_answer(context, field_dict[idx])
            extracted_data.append(f"{validated_answer if validated_answer else 'Unknown'}")
        else:
            # Ask the model each question, providing the entire cleaned context
            result = nlp(question=question, context=context)
            answer = result['answer']
            
            # Validate and format the answer based on its type
            validated_answer = validate_and_format_answer(answer, field_dict[idx])
            
            # Store the answer, use 'Unknown' if validation failed
            extracted_data.append(f"{validated_answer if validated_answer else 'Unknown'}")

        
    return extracted_data

def goofy_ahh(context):
    fields = extract_fields(context)
    context = clean_text(context)
    nlp = pipeline('question-answering', model=model_name, tokenizer=model_name)
    
    response_data = {}
    
    for i in range(len(fields)):
        if "Unknown" in fields[i] and i != 2:
            result = nlp(question=questions2[i], context=context)
            validated_answer = validate_and_format_answer(result['answer'], field_dict[i])
            response_data[field_dict[i]] = validated_answer if validated_answer else 'Unknown'
        else:
            response_data[field_dict[i]] = fields[i]
    
    return response_data


@app.route('/autofilling', methods=['POST'])
def autofill_fields():
    try:
        data = request.get_json()
        user_input = data.get('context', '')
        
        result = goofy_ahh(user_input)
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(debug=True)