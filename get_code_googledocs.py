import os
import io
import re
from googleapiclient.discovery import build
from google.oauth2 import service_account
from git import Repo

# Google Docs API credentials
SCOPES = ['https://www.googleapis.com/auth/documents.readonly']
SERVICE_ACCOUNT_FILE = '/Users/ryanjing/matlab-pull-project-accd04b13ab0.json'  # Update with your credentials file

# Git repository settings
REPO_PATH = '/Users/ryanjing/MatLab_Projects/355_Project/Foot-Drop-FES-Model'  # Path to clone the repository
FILE_PATH = '/Users/ryanjing/MatLab_Projects/355_Project/Foot-Drop-FES-Model/BME_355_Project_Model_Implementation.m'

def read_google_doc(service, doc_id):
    doc = service.documents().get(documentId=doc_id).execute()
    content = ''
    for element in doc.get('body').get('content'):
        if 'paragraph' in element:
            paragraph = element['paragraph']
            for elem in paragraph['elements']:
                if 'textRun' in elem:
                    text_run = elem['textRun']
                    if 'content' in text_run:
                        content += text_run['content']
                content += '\n'  # Add a newline after each paragraph
    return content

def main():
    # Authenticate with Google Docs API
    credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE, scopes=SCOPES)
    service = build('docs', 'v1', credentials=credentials)

    # Read the Google Docs file content
    doc_id = '1afZ1KtkHvkHk6-m-ujB37t8B9DOTES-2cromKDjRjXs'
    google_doc_content = read_google_doc(service, doc_id)

    print(google_doc_content)

    with open(FILE_PATH, 'w') as file:
        file.write(google_doc_content)

    # Call the shell script to add, commit, and push changes
    os.system("/Users/ryanjing/MatLab_Projects/355_Project/Foot-Drop-FES-Model/git_push.sh")
    print("Changes pushed to the repository.")

if __name__ == '__main__':
    main()
