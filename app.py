from flask import Flask, send_file, send_from_directory


app = Flask(__name__, static_folder="assets", static_url_path="/assets")


@app.get("/")
def home():
    return send_file("index.html")


@app.get("/manifest.webmanifest")
def manifest():
    return send_from_directory(".", "manifest.webmanifest", mimetype="application/manifest+json")


@app.get("/service-worker.js")
def service_worker():
    return send_from_directory(".", "service-worker.js", mimetype="application/javascript")


@app.get("/health")
def health():
    return {"status": "ok"}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
