import express from "express";
import { authenticate } from "../middleware/authenticate.js";
import { authorizeModification } from "../middleware/authorize.js";
import {
  getWatchlist,
  addMovie,
  updateMovie,
  deleteMovie
} from "../utils/db.js";

const router = express.Router();

// All watchlist routes require authentication.
router.use(authenticate);

// View a user's watchlist.
router.get("/:userId", (req, res) => {
  const userId = Number(req.params.userId);
  const watchlist = getWatchlist(userId);

  if (watchlist === null) {
    return res.status(404).json({ error: "User not found." });
  }

  res.status(200).json(watchlist);
});

// Add a movie.
router.post("/:userId/movies", authorizeModification, (req, res) => {
  const userId = Number(req.params.userId);
  const { title, genre } = req.body ?? {};

  if (typeof title !== "string" || !title.trim()) {
    return res.status(400).json({
      error: "A movie title is required."
    });
  }

  const movie = addMovie(userId, { title, genre });

  if (movie === null) {
    return res.status(404).json({ error: "User not found." });
  }

  res.status(201).json(movie);
});

// Update a movie.
router.put("/:userId/movies/:movieId", authorizeModification, (req, res) => {
  const userId = Number(req.params.userId);
  const movieId = Number(req.params.movieId);
  const body = req.body ?? {};
  const updates = {};

  if (Object.hasOwn(body, "title")) {
    if (typeof body.title !== "string" || !body.title.trim()) {
      return res.status(400).json({
        error: "A movie title is required."
      });
    }

    updates.title = body.title;
  }

  if (Object.hasOwn(body, "genre")) {
    updates.genre = body.genre;
  }

  if (Object.hasOwn(body, "watched")) {
    if (typeof body.watched !== "boolean") {
      return res.status(400).json({
        error: "Watched must be a boolean."
      });
    }

    updates.watched = body.watched;
  }

  const movie = updateMovie(userId, movieId, updates);

  if (movie === null) {
    return res.status(404).json({
      error: "User or movie not found."
    });
  }

  res.status(200).json(movie);
});

// Delete a movie.
router.delete("/:userId/movies/:movieId", authorizeModification, (req, res) => {
  const userId = Number(req.params.userId);
  const movieId = Number(req.params.movieId);
  const deleted = deleteMovie(userId, movieId);

  if (deleted === null) {
    return res.status(404).json({
      error: "User or movie not found."
    });
  }

  res.status(200).json({ message: "Movie deleted." });
});

export default router;