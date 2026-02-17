from flask import Flask, jsonify
from db.database import engine

app = Flask(__name__)

@app.route("/findings")
def get_findings():
    with engine.connect() as conn:
        result = conn.execute("SELECT * FROM compliance_findings;")
        findings = [dict(row) for row in result]
    return jsonify(findings)

if __name__ == "__main__":
    app.run(debug=True)
