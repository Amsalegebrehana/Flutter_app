const User = require("../models/user_model");
const { registerValidation, loginValidation } = require('../middlewares/validation')
const bcrypt = require('bcryptjs');
const { JsonWebTokenError } = require('jsonwebtoken');
const jwt = require('jsonwebtoken');


const login = async (req, res) => {
    const { error } = loginValidation(req.body);

    const user = await User.findOne({ email: req.body.email });
    if (!user) {
        return res.status(400).send('Email or password is incorrect');
    }

    const validPass = await bcrypt.compare(req.body.password, user.password);
    if (!validPass) {
        return res.status(400).send('Email or password is incorrect');
    }

    const token = jwt.sign({
        _id: user._id
    }, process.env.TOKEN_SECRET)
    const userStore = {
        role: user.role,
        id: user._id,
        token: token
    };

    res.status(200).send(userStore);
};

const register = async (req, res) => {
    const { error } = registerValidation(req.body);

    if (error) {
        return res.status(400).send((error.details[0].message).toString());
    }

    const emailExist = await User.findOne({ email: req.body.email });
    if (emailExist) {
        return res.status(400).send('Email already exists');
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);

    const usersList = new User({
        firstname: req.body.firstname,
        lastname: req.body.lastname,
        password: hashedPassword,
        email: req.body.email,
        role: req.body.role,
        phone: req.body.phone,
        image: req.body.image,
        address: req.body.address,
    });


    usersList
        .save()
        .then((result) => {
            const token = jwt.sign({
                _id: result._id
            }, process.env.TOKEN_SECRET);
            const postResult = {
                id: result._id,
                role: result.role,
                token: token
            };
            res.status(200).send(postResult);
        })
        .catch((err) => {
            console.log(err);
        });
};


const getUsers = (req, res) => {
    User
        .find()
        .then((users) => {
            res.json(users);
        })
        .catch((err) => {
            res.json(
                { message: err.message }
            );
        });
}

const getUserById = (req, res) => {
    User
        .findById(req.params.id)
        .then((users) => {
            res.json(users)
        })
        .catch((err) => {
            res.json(
                { message: err.message }
            );
        });
}

const getUserByEmail = (req, res) => {
    User
        .find({email:req.params.email})
        .then((users) => {
            res.json(users)
        })
        .catch((err) => {
            res.json(
                { message: err.message }
            );
        });
}


const updateUser = function (req, res) {
    console.log(req);
    if (!req.body) {
        return res.status(400).send({
            message: "Data to update can not be empty!"
        });
    }
    User.findByIdAndUpdate(
        {
            _id: req.params.id
        },

        req.body,
        { new: true },

    )

        .then((user) => {
            if (!user) {
                res.status(404).send({
                    message: `Couldn't update user with id ${req.params.id}`
                });
            }
            else {

                res.status(201).send(user);
            }

        }).catch((err) => {
            res.status(500).send({
                message: `Error updating ${req.params.id}`
            })
        })
}


const deleteUser = (req, res) => {
    User
        .findByIdAndDelete(req.params.id)
        .then((user) => {
            res.status(200).json({
                body: user,
                message: `Deleted user ${user._id} Successfully`
            });
        })
        .catch((err) => {
            res.json({
                message: err.message
            }
            );
        });
}

const logout = (req, res) => {
    const authToken = req.headers.authtoken;
    jwt.sign(authToken, "", { expiresIn: 0.1 }, (logout, err) => {
        if (logout) {
            res.send({
                msg: 'You have been Logged Out',
                token: null
            });
        } else {
            res.send({ msg: 'Error' });
        }
    });

};

module.exports = { register, getUsers, getUserById, deleteUser, login, logout, updateUser, getUserByEmail }; //EXPORT YOUR FUNCTIONS HERE