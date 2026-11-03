const express = require('express');
const app = express();

// 1. Root route
app.get('/', (req, res) => {
  res.send("Welcome to Camper Bot's homepage!");
});

// 3. Hobbies route
app.get('/hobbies', (req, res) => {
  res.send("I cycle, go boating, and play guitar.");
});

// 3. Skills route (or route 5)
app.get('/skills', (req, res) => {
  res.send("JavaScript, Node.js, and Express.js!");
});

// 4. API profile route
app.get('/api/profile', (req, res) => {
  res.json({
    name: "Camper Bot",
    hobbies: ["cycling", "boating", "guitar"],
    skills: ["JavaScript", "Node.js", "Express.js"]
  });
});

// Listen on port 3000
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});