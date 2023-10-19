from bp import better_profanity
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/profanity', methods=['POST'])
def profanity_check():
    try:
        data = request.get_json()
        user_input = data.get('input', '')
        profanity = better_profanity.Profanity()
        return jsonify({"Profane": profanity.contains_profanity(user_input)})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(debug=True)