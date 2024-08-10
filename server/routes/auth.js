const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");



authRouter.post("/api/signup", async (req, res) => {
  try {
    console.log('1');
    const { name, email, password ,forgotpass} = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      console.log('2');
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
    console.log('3');

    let user = new User({
      forgotpass,
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({error:error.message });
  }
});



authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

authRouter.post('/api/update', async (req, res) => {
  const { name, password, email,id } = req.body;
  console.log( name, password, email,id )
  try {
    const user = await User.findOne({ _id: id });
    if(!id){
      console.log("hi");
      return res.status(404).send("please enter id");
    }
    if (!user) {
      console.log(id);
      return res.status(404).send('User not found');
    }

    if (name) {
      console.log(name);
      user.name = name;
    }

    if (password) {
      console.log(password);
      const salt = await bcryptjs.genSalt(10);
      user.password = await bcryptjs.hash(password, salt);
    }

    if (email) {
      console.log(email);
      user.email = email;
    }

    await user.save();
   return res.send('Login details updated');
  } catch (error) {
    res.status(500).json({error:error.message})
  }
});
/*
authRouter.delete('/api/delete', async (req, res) => {
  const { _id } = req.body;

  if (!_id) {
    console.log('1');
    return res.status(400).send('Please provide an ID');
  }

  try {
    const user = await User.findByIdAndDelete(_id);
    console.log('2');

    if (!user) {
      console.log('3');

      return res.status(404).send('User not found');
    }
    console.log('4');

    res.send('User deleted successfully');
  } catch (error) {
    console.log('5');
    res.status(500).send('Server error');
  }
});*/
authRouter.delete('/api/delete', async (req, res) => {
  const { _id } = req.body;

  if (!_id) {
    console.log('No ID provided');
    return res.status(400).send('Please provide an ID');
  }

  try {
    console.log('Attempting to delete user with ID:', _id);
    const user = await User.findByIdAndDelete(_id);

    if (!user) {
      console.log('User with ID', _id, 'not found');
      return res.status(404).send('User not found');
    }

    console.log('User with ID', _id, 'deleted successfully');
    res.send('User deleted successfully');
  } catch (error) {
    console.error('Server error:', error);
    res.status(500).send('Server error');
  }
});

authRouter.post("/api/forgot", async (req, res) => {
  try {
    const { email, forgotpass } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "User with this email does not exist!" });
    }

    
    const isMatch =forgotpass;
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect recovery password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    console.error('Error in /api/forgot:', e);
    res.status(500).json({ error: e.message });
  }
})

authRouter.post('/api/fav', async (req, res) => {
  const { email, liked } = req.body;
  console.log(email, liked);

  try {
    const user = await User.findOne({ email: email });

    if (!email) {
      console.log("hi");
      return res.status(404).send("please enter email");
    }

    if (liked) {
      console.log(liked);
      user.liked.push(liked);
    }

    await user.save();
    return res.send('favourites added in database');
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


authRouter.get('/api/fav2', async (req, res) => {
  const email = req.query.email;

  if (!email) {
    return res.status(400).send('Email query parameter is required');
  }

  try {
    const user = await User.findOne({ email: email });
    if (!user) {
      return res.status(404).send('User not found');
    }

    
    user.liked.forEach((likedItem, index) => {
      console.log(`Liked item ${index + 1}:`, likedItem); 
    });

    res.json({ liked: user.liked });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
})


module.exports = authRouter;