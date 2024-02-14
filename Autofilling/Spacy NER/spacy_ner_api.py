import spacy
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/autofill", methods=["POST"])
def extract_job_information():
    try:
        data = request.get_json()
        job_description = data.get('input', '')

        nlp = spacy.load("en_core_web_sm")
        doc = nlp(job_description)

        company_name = ""
        position = ""
        description = ""
        deadline = ""
        location = ""
        mode = ""
        job_type = ""
        gender = ""
        experience_required = ""

        for ent in doc.ents:
            if ent.label_ == "ORG":
                company_name = ent.text
            elif ent.label_ == "POSITION":
                position = ent.text
            elif ent.label_ == "DESCRIPTION":
                description = ent.text
            elif ent.label_ == "DATE":
                deadline = ent.text
            elif ent.label_ == "GPE":
                location = ent.text
            elif ent.label_ == "MODE":
                mode = ent.text
            elif ent.label_ == "TYPE":
                job_type = ent.text
            elif ent.label_ == "GENDER":
                gender = ent.text
            elif ent.label_ == "EXPERIENCE":
                experience_required = ent.text

        result = {
        "company_name": company_name,
        "position": position,
        "description": description,
        "deadline": deadline,
        "location": location,
        "mode": mode,
        "job_type": job_type,
        "gender": gender,
        "experience_required": experience_required,
        }

        return jsonify({"results": result})
    except Exception as e:
        return jsonify({"error": str(e)})


if __name__ == "__main__":
    app.run(debug=True)