# 📂 User Details Submission Form (CFML)

A simple user information submission form built using **ColdFusion (CFML)**, allowing users to enter and manage data like Name, Email, Password, and Phone Number. The data is styled using CSS and submitted via ColdFusion components.

![Form Screenshot](./99059ce9-e636-4027-b0ae-a1ed9ff24fc7.png)

---

## 🚀 Features

* Responsive input form using HTML and CSS
* Styled with a clean layout (`style.css`)
* Form validation and structured input fields
* Modular CFML components for separation of concerns
* List and Submit functionalities implemented

---

## 🧾 Project Structure

```bash
📁 CFML-UserForm/
├── index.cfm           # Main form interface
├── style.css           # Styling for form and table
├── submit.cfc          # Handles form submission logic
├── options.cfc         # Handles list and utility functions
├── data.cfc            # Data operations (store, fetch, etc.)
└── 99059ce9-....png     # Screenshot of output
```

---

## ⚙️ How It Works

1. **index.cfm** presents a user form to input name, email, password, and phone number.
2. Data is submitted to `submit.cfc` for processing.
3. Additional functionality like listing users is provided via `options.cfc`.
4. `data.cfc` manages storage and retrieval of records.
5. The layout and table formatting are defined in `style.css`.

---

## 📅 Technologies Used

* **CFML (ColdFusion Markup Language)**
* **HTML5 & CSS3**
* **ColdBox MVC Concepts (modular components)**

---

## 💼 Learning Outcomes

* Gained experience building real-world CFML applications.
* Applied modular architecture using components.
* Worked collaboratively on form-based data processing projects.
* Learned styling and layout design using CSS.

---

## 📖 Usage

1. Clone or download the repository.
2. Place it inside your ColdFusion web root.
3. Make sure your CFML server (Adobe CF / Lucee) is running.
4. Navigate to `http://localhost/User-login/index.cfm`
5. Fill the form and test both **Submit** and **List** actions.

---

## 🔧 Future Improvements

* Add client-side validation
* Store records in a database
* Add user edit and delete functionalities
* Improve responsiveness for mobile

---

> *Built as part of hands-on internship learning.*
