import fitz  # PyMuPDF
import docx


def extract_text_pdf(path):
    doc = fitz.open(path)
    return " ".join([page.get_text() for page in doc])


def extract_text_docx(path):
    doc = docx.Document(path)
    return " ".join([p.text for p in doc.paragraphs])
