~~~
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Function to check if the user is an admin
    function isAdmin() {
      return request.auth != null && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }

    // Function to check if the user is a moderator
    function isModerator() {
      return request.auth != null && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'moderator';
    }

    // Function to check if the user is a regular user
    function isUser() {
      return request.auth != null;
    }

    // Admin has full read and write access to everything
    match /{document=**} {
      allow read, write: if isAdmin();
    }
    
    // Moderator has full read access to everything
    match /{document=**} {
      allow read: if isModerator();
    }

    // Moderator and User can read settings and workZones. User & Moderator can write own user data.
    match /settings/{document=**} {
      allow read: if isUser();
    }
    match /workZones/{document=**} {
      allow read: if isUser();
    }

    match /users/{userId} {
      allow read: if isUser();
      allow write: if isUser() && request.auth.uid == userId;
    }

    // User can read their own attendance, and write today's attendance
    match /users/{userId}/attendance/{date} {
      allow read, create, update: if isUser() && request.auth.uid == userId;
    }
  }
}
~~~