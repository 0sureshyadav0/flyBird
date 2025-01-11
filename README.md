# 🕊️ FlyBird

A simple mail generator app which uses AI to generate mail based on user's subject.

---

## 🌟 Features

- **Easy Access**: Access from anywhere, anytime
- **Time Management**: You don't have to write email from scratch which increase efficiency.
- **Direct Send**: Direct send email within the app. You don't need to copy the generated email and paste it in your email client inorder to send.
- **Inbuilt Subject**:It provides some inbuilt subjects like "Meeting Invitation", "Job Offer", "Projects Update", etc.
- **Custom Subject**: User can input their own subject matter.

---

## 🌟 Upcoming Features

- **Storage**: Store the generated email and use it in future.

## 📱 Screenshots

### Preview

<center>
<div style="display:flex;gap:20px;">
<img src="./assets/images/img1.jpg" height = "720px" width="300px">
<img src="./assets/images/img2.jpg" height = "720px" width="300px">
<img src="./assets/images/img3.jpg" height = "720px" width="300px">
</div>

</center>

---

# For Users

## How to install

- Click the Download button to download the app from MediaFire.
- Allow permission to install app from unknown sources.

  - **Note**: It will say that the app may contain some malware but I haven't added anything like that. It is safe to install.
  - If you have still confusion/doubt then feel free to ask anything about it.

- After installation, open the app and follow the instruction that is being provided in the app carefully otherwise app may not perform task.
- And here you go. Enjoy the app
- Don't forget to give feedback about adding some features or something found unexpected.

# For Developer

## 🚀 Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/0sureshyadav0/flyBird.git
   ```

2. Navigate to the project directory:

   ```bash
   cd flyBird
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## 🛠️ Technologies Used

- **Flutter**: The app framework.
- **Dart**: Programming language.
- **Provider Package**: For state management.
- **Get Package**: For navigation and snackbars.
- **AI Tool**: `huggingface.co/models/google/flan-t5-large` to generate emails
- **mailer Package**: To send direct emails.

## Dependencies Used

```bash
  http: ^1.2.2
  get: ^4.6.6
  google_fonts: ^6.2.1
  mailer: ^6.3.0
  provider: ^6.1.2
  hive_flutter: ^1.1.0
  page_transition: ^2.1.0
  lottie: ^3.3.0
```

---

## 📂 Project Structure

```plaintext
flyBird/
├── lib/
│   ├── components/
│   │   ├── drop_down.dart
│   │   ├── gradient_button.dart
│   │   └── text_field.dart
│   ├── consts/
│   │   ├── consts.dart
│   ├── providers/
│   │   └── email_provider.dart
│   ├── screens/
│   │   ├── generaed_email.dart
│   │   ├── home_page.dart
│   │   └── loading_screens.dart
│   │   └── settings.dart
│   │   └── stepper.dart
│   └── main.dart
├── assets/
│   ├── images/
│   │   └── background.jpeg
│   ├── lottie/
│       └── loading.json
└── pubspec.yaml
```

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## 🧑‍💻 Developer

- **🧔 Suresh Yadav**
- 🌐 [sureshyadav.info.np](http://sureshyadav.info.np)

---

## 🙌 Contribution

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

## 📞 Support

For any issues or feedback, contact [Suresh Yadav](mailto:sureshyadav.info.np@gmail.com).

---

Enjoy your music with **FlyBird**! 🕊️
