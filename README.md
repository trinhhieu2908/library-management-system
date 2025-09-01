# Library Management System

A simple Django-based Library Management System for managing books, students, and book transactions.

## 🚀 Features

### 📚 Book Management

- Add new books with ID, name, subject, and category
- View all books in dashboard
- Edit book details (ID, name, subject, category)
- Delete books
- Search books by book ID

### 👥 Student Management

- Add students with name and student ID
- View all students
- Search students by student ID

### 📖 Book Transactions

- Issue books to students (15-day expiry)
- Return books and update status
- View all issued books with fine calculation (10 per day after 15 days)

### 🔐 User Authentication

- Staff registration and login
- Session-based authentication
- Logout functionality

## 🛠️ Technology Stack

- **Backend**: Django 3.0.5
- **Database**: SQLite3
- **Frontend**: HTML, CSS, Bootstrap 4.3.1
- **JavaScript**: jQuery 3.3.1

## 📋 Prerequisites

- **Python**: 3.6 - 3.9 (recommended: Python 3.8)
- **Django**: 3.0.5

## 🚀 Installation & Setup

### Environment Setup

**If you are not using conda**: I recommend you to download and use Python 3.8

**If you are using conda**: Follow these steps to have a better isolated environment:

```bash
conda create -n library-system python=3.8
conda activate library-system
```

Then follow the steps below:

### Step 1: Install Django

```bash
pip install django==3.0.5
```

### Step 2: Run Database Migrations

```bash
python manage.py migrate
```

### Step 3: Create Superuser (Optional)

```bash
python manage.py createsuperuser
```

### Step 4: Load Sample Data (Optional)

```bash
python manage.py load_sample_data
```

**Note:** You need to run `python manage.py createsuperuser` before doing this.

### Step 5: Start the Development Server

```bash
python manage.py runserver
```

## 🌐 Accessing the Application

- **Main Application**: http://127.0.0.1:8000/ or http://localhost:8000/
- **Admin Panel**: http://127.0.0.1:8000/admin/ (Django's built-in admin interface), can only access after creating createsuperuser

## 📖 How to Use

### First Time Setup

1. Visit http://localhost:8000/
2. Click "Staff" in navigation
3. Click "Create an account" to create staff account
4. Login with your credentials

### Adding Books

1. Login to staff portal
2. Click "Add Book" in sidebar
3. Fill in book details (ID, name, subject, status)
4. Click "Add Book"

### Adding Students

1. Click "Add Student" in sidebar
2. Enter student name and student ID
3. Click "Add Student"

### Issuing Books

1. Click "Issue Book" in sidebar
2. Enter student ID and book ID
3. Click "Issue Book"

### Returning Books

1. Click "Return Book" in sidebar
2. Enter book ID to return
3. Click "Return Book"

### Viewing Records

- **Dashboard**: View all books with status
- **View Issued Book**: See issued books with fines
- **View Student**: Browse all students

## 🗄️ Database Models

- **UserExtend**: User profiles with phone numbers
- **AddBook**: Book information (ID, name, subject, category)
- **AddStudent**: Student information (name, student ID)
- **IssueBook**: Book issuing records
- **ReturnBook**: Book return records

## Available Functions

### Authentication

- `SignupBackend()` - Staff registration
- `LoginBackend()` - Staff login
- `HandleLogout()` - Logout

### Book Management

- `addbook()` - Add book page
- `AddBookSubmission()` - Process book addition
- `deletebook(id)` - Delete book
- `editbookdetails(id)` - Edit book page
- `updatedetails(id)` - Update book details
- `Search()` - Search books

### Student Management

- `addstudent()` - Add student page
- `addstudentsubmission()` - Process student addition
- `viewstudents()` - View all students
- `Searchstudent()` - Search students

### Book Transactions

- `bookissue()` - Issue book page
- `issuebooksubmission()` - Process book issuing
- `returnbook()` - Return book page
- `returnbooksubmission()` - Process book return
- `viewissuedbook()` - View issued books

### Pages

- `index()` - Homepage
- `staff()` - Staff portal
- `stafflogin()` - Login page
- `staffsignup()` - Signup page
- `dashboard()` - Dashboard
- `addbook()` - Add book page
- `addstudent()` - Add student page
- `bookissue()` - Issue book page
- `returnbook()` - Return book page
- `viewissuedbook()` - View issued books page
- `viewstudents()` - View students page
- `editbookdetails()` - Edit book details page

## 🐛 Troubleshooting

### Port Already in Use

```bash
python manage.py runserver 8001
```

### Database Errors

```bash
rm db.sqlite3
python manage.py migrate
```

### Session/Base64 Errors

```bash
python manage.py clearsessions
```

## 📝 Notes

- Uses SQLite3 database (file-based)
- Fine calculation: 10 per day after 15 days
- Book issue period: 15 days
