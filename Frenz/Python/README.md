# Frenz - Python 

This python script allows a new document within the "university" collection to be inserted in Firebase. If we do plan on expanding to other universities, you would make changes to the python script regarding details about the university (ex: email domain, prompts, coordinates, etc.) before running it. 

## Usage
Use the package manager pip to install firebase_admin.
```bash
pip install firebase_admin
```

```python
# Adds a new university to the university collection
add_new_university_to_collection()
```
To run the entire script, type the following in the command line prompt: 
```bash 
python frenzDocumentFetch.py
```

## Support

If you need additional help and/or would like to access the service Account Key, please contact me at: rodriguez.aranza.9801@gmail.com.


### Firebase Permission Issues
If you are experiencing Firebase permission issues when running this script, this means that the security rules must be changed. Currently, the rules are set so that the "university" collection can only be read. To change this, go to Cloud Firestore > Rules > and replace the following:

```
    match /universities/{document=**} {
    	
      allow read: if request.auth != null && 
      hasAllowedDomainOrException(request.auth.token.email);
      
    }
```
to this: 

```
    match /universities/{document=**} {
    	
      allow update;
      
    }
```
**Important Note**: Immediately after a new university has been successfully uploaded to the Firebase collection, please ensure to revert the permission rules back to the original rule. 