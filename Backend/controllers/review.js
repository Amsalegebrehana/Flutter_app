const Review = require("../models/review_model");

const getReviews = (req, res) => {
    Review
        .find()
        .then((reviews) => {
            res.status(200).json(reviews);
        })
        .catch((err) => {
            res.json(
                {message: err.message}
            );
        });
}


const getReviewById = (req, res) => {
    Review
        .findById(req.params.id)
        .then((reviews) => {
            res.status(200).json(reviews)
        })
        .catch((err) => {
            res.json(
                {message: err.message}
            );
        });
}


const addReview = (req, res) => {
    new Review({
        rating: req.body.rating,
        comment: req.body.comment,
        order_id: req.body.order_id
    })
    .save()
    .then((review) => {
        res.status(200).json({
            body: review,
            message: `Inserted Review Successfully`
        });
    })
    .catch((err) => {
        res.json({
            message: err.message
        });
    });       
}





// const deleteReview = (req, res) => {
//     Review
//         .findByIdAndDelete(req.params.id)
//         .then((review) => {
//             res.status(200).json({
//                 body: review,
//                 message: `Deleted Review Successfully`
//             });
//         })
//         .catch((err) => {
//             res.json({
//                 message: err.message
//             }
//             );
//         });
// }



module.exports={ getReviews, getReviewById, addReview}; //EXPORT YOUR FUNCTIONS HERE