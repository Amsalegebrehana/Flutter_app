const mongoose  = require("mongoose");
const Order = require("../models/order_model");
const User= require("../models/user_model");
const Review= require("../models/review_model");

let objectId= mongoose.Types.ObjectId;

const date = new Date();
const randomnum = Math.floor(Math.random() * 9999) + 1000;// random number for b/n 1000-9999 for the unique code

const timeS = new Date();
const time_now = `${timeS.getHours()}` + `${timeS.getMinutes()}` +`${timeS.getSeconds()}`;// to get the current time
const time_now_calc = `${timeS.getHours()}` + `${timeS.getMinutes()}` +`${timeS.getSeconds()}`;// to get the current time

const orderdate = new Date(timeS.getTime()); 

async function asyncForEach(jobs,callback){
    for (let i=0;i<jobs.length;i++){
        await callback(jobs[i],i,jobs);
    };
};


//get all orders
const ordergetAllCompleted = function(req, res){
    Order.find({is_completed:true})
        .then((orders)=>{
            if(!orders){ 
                res.status(404)
                .json({message: `Couldn't find order!`});
            }
            else
           {  
               console.log(orders);
            if(orders.length!=0){
                let lst=[];
                 const toList= async()=>{
                    await asyncForEach(orders,async(order)=>{

                        console.log("order");
                        const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                    if(err){
                                        return err
                                    }else if (userObj){
                                        return userObj
                                    }else{
                                        return null
                                    }
                                });
        
                        const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });
                        
                        const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });
        
                        lst.push({
                                "User":JSON.parse(JSON.stringify(findUser))[0],
                                "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                                "Order":order,
                                "Review":JSON.parse(JSON.stringify(findReview))[0]
                            });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
        
            }
            else{
                res.status(400).send("No completed orders to show");
           }
            
           }
        })
        .catch((err) => {
            res.json(
                {message: err.message}
            );
        });

};


const ordergetAll = function(req, res){
    Order.find({seeker_id:req.params.id})
        .then((orders)=>{
            if(!orders){ 
                res.status(404)
                .json({message: `Couldn't find order!`});
            }
            else
           {  
            if(orders.length!=0){
                let lst=[];
                 const toList= async()=>{
                    await asyncForEach(orders,async(order)=>{
                        const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                    if(err){
                                        return err
                                    }else if (userObj){
                                        return userObj
                                    }else{
                                        return null
                                    }
                                });
        
                        const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });
                        
                        const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });
        
                        lst.push({
                                "User":JSON.parse(JSON.stringify(findUser))[0],
                                "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                                "Order":order,
                                "Review":JSON.parse(JSON.stringify(findReview))[0]
                            });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
        
            }
            else{
                res.status(400).send("No orders to show");
           }
            
           }
        })
        .catch((err) => {
            res.json(
                {message: err.message}
            );
        });

};


//get a single order by seeker_id
const ordergetById = function(req, res){
    const s_id = {seeker_id:req.params.id}; // s_id to the requested id
    Order.find(s_id)
    .then((order)=>{
        if(!order){
            res.status(404)
            .send({message: `Couldn't Find id ${req.params.id}`});
        }
        else
        {res.status(200).send(order);}
       
    }).catch((err) => {
        res.json(
            {message:`Id ${req.params.id} Not Found`}
        );
    });
};

const ordergetByOrderId = function(req, res){// s_id to the requested id
    Order.find({_id:req.params.id})
        .then((orders)=>{
            if(!orders){ 
                res.status(404)
                .json({message: `Couldn't find order!`});
            }
            else
           {  
            if(orders.length!=0){
                let lst=[];
                 const toList= async()=>{
                    await asyncForEach(orders,async(order)=>{
                        const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                    if(err){
                                        return err
                                    }else if (userObj){
                                        return userObj
                                    }else{
                                        return null
                                    }
                                });
        
                        const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });
                        
                        const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });
        
                        lst.push({
                                "User":JSON.parse(JSON.stringify(findUser))[0],
                                "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                                "Order":order,
                                "Review":JSON.parse(JSON.stringify(findReview))[0]
                            });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
        
            }
            else{
                res.status(400).send("No order to show");
           }
            
           }
        })
        .catch((err) => {
            res.json(
                {message: err.message}
            );
        });
};



//post order
const orderPost = function(req, res){
   new Order({
        status : "pending",
        is_completed : false,
        order_created_date : orderdate,
        saved_time: 0,
        unique_code : randomnum,
        seeker_id : req.body.seeker_id,
        provider_id : req.body.provider_id,
        

    })
    .save()
    .then((orders)=>{
        if(!orders){
            res.status(404)
            .send({message: `Couldn't post`});
        }
        else{res.status(201).json({
            order : orders,
            message: `order added`
        });}
    }).catch((err)=>{
        res.json(
            {message: err.message}
        );
    })
};

const getActiveOrder= async function(req,res){
    try{
        const orders= await Order.find({seeker_id:req.params.id,status:"active"});
        let lst=[];
        if(orders.length!=0){
            const toList= async()=>{
                await asyncForEach(orders,async(order)=>{
                    const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":order,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No active orders!");
        }

    }catch(err){
        console.log("Error finding an active order: ",err);
    }
}

const getPendingOrders= async function(req,res){
    try{
        const orders= await Order.find({seeker_id:req.params.id,status:"pending"});
        let lst=[];
        if(orders.length!=0){
            const toList= async()=>{
                await asyncForEach(orders,async(order)=>{
                    const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":order,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No pending orders!");
        }

    }catch(err){
        console.log("Error finding pending orders: ",err);
    }
}

const getDeclinedOrders= async function(req,res){
    try{
        const orders= await Order.find({seeker_id:req.params.id,status:"declined"});
        let lst=[];
        if(orders.length!=0){
            const toList= async()=>{
                await asyncForEach(orders,async(order)=>{
                    const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":order,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No declined orders!");
        }

    }catch(err){
        console.log("Error finding declined orders: ",err);
    }
}

const getCompletedOrders= async function(req,res){
    try{
        const orders= await Order.find({seeker_id:req.params.id,is_completed:true});
        let lst=[];
        if(orders.length!=0){
            const toList= async()=>{
                await asyncForEach(orders,async(order)=>{
                    const findUser = await User.find({_id:order.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:order.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    
                    const findReview= await Review.find({order_id:order._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":order,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No completed orders!");
        }

    }catch(err){
        console.log("Error finding completed orders: ",err);
    }
}

//update order using seeker id
const orderUpdate = async function(req, res) {
    try{
        const order_id= req.params.id;
        const progress= req.body.progress;
        const order= await Order.findById(order_id);
        const provider= await User.findById(order.provider_id);
        // console.log(order.saved_time);
        console.log(order.provider_id);
        if(progress=="started"){
            let current_time=new Date();
            let minutes= current_time.getMinutes()/60;
            let seconds= current_time.getSeconds()/3600;
            const start_time=current_time.getHours()+minutes+seconds;
            
             const job= await Order.findOneAndUpdate({_id:order_id},
            {
                $set: {start_time:start_time,
                        progress:"started"
                    }
            },
            {
                useFindAndModify:true,
            }
              
            );

                res.status(201).json(job);
        }
        else if(progress=="paused"){
            const start_time=order.start_time;
            const pre_saved_time= order.saved_time;
            let current_time=new Date();
            let minutes= current_time.getMinutes()/60;
            let seconds= current_time.getSeconds()/3600;
            const paused_time=current_time.getHours()+minutes+seconds;
            const saved_time=pre_saved_time+(paused_time-start_time);
            
            const job= await Order.findOneAndUpdate({_id:order_id},
                {
                    $set: {saved_time:saved_time,
                            progress:"paused"
                        }
                },
                {
                    useFindAndModify:true,
                }
                  
                );
    
                    res.status(201).json(job);

        }
        else if(progress=="finished"){
            const start_time=order.start_time;
            const pre_saved_time= order.saved_time;
            let current_time=new Date();
            let minutes= current_time.getMinutes()/60;
            let seconds= current_time.getSeconds()/3600;
            const finished_time= current_time.getHours()+minutes+seconds;
            const saved_time= pre_saved_time +(finished_time-start_time);
            const final_payment= saved_time* provider.per_hour_wage;
            const completed_date= new Date();
            // const order_completed_date= new Date(completed_date.getTime());
            // console.log(order_completed_date);
            const job= await Order.findOneAndUpdate({_id:order_id},
                {
                    $set: {saved_time:saved_time,
                            final_payment:final_payment,
                            is_completed:true,
                            progress:"finished",
                            order_completed_date:orderdate,
                            status:"completed"
                        }
                },
                {
                    useFindAndModify:true,
                }
                  
                );
    
                    res.status(201).json(job);
        }

        

    }catch(err){
        console.error("Error updating status: ",err);
        
    }
}


//delete order using seeker id
const orderDelete = function(req, res){
    Order.findByIdAndDelete({_id:req.params.id})
        .then((result)=>{
            if(!result){
                res.status(404)
                .send({message: `Couldn't Find id ${req.params.id}`});
            }
            else
            {res.status(200).send(result);}
            // console.log(`${req.params.id} deleted`);
        })
        .catch((err)=>{
            console.log(msg.err);
        })

};



const getAllJobs = async (req,res) =>{
    try{
        
        let jobs= await Order.find({provider_id: req.params.id});
        let lst=[]
        if(jobs.length!=0){
        const toList= async()=>{
            await asyncForEach(jobs,async(job)=>{
                const findUser = await User.find({_id:job.seeker_id},(err,userObj)=>{
                            if(err){
                                return err
                            }else if (userObj){
                                return userObj
                            }else{
                                return null
                            }
                        });

                const findProvider= await User.find({_id:job.provider_id},(err,userObj)=>{
                    if(err){
                        return err
                    }else if (userObj){
                        return userObj
                    }else{
                        return null
                    }
                });
                const findReview= await Review.find({order_id:job._id},(err,userObj)=>{
                    if(err){
                        return err
                    }else if (userObj){
                        return userObj
                    }else{
                        return null
                    }
                });
                // console.log(findUser);
                lst.push({
                        "User":JSON.parse(JSON.stringify(findUser))[0],
                        "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                        "Order":job,
                        "Review":JSON.parse(JSON.stringify(findReview))[0]
                    });

                // console.log(lst)
            });

            res.status(200).send(lst);
        };

        toList();

    }else{
        res.status(400).send("No jobs to show");
    }
        
    }catch(err){
        console.error("Error finding jobs: ",err)
    }
}

const updateJobStatus= async (req,res)=>{
    try{
        const order_id= req.params.id;
        const status= req.body.status;
        const jobs= await Order.find({_id:order_id});
        if(status=="active"){
            const checkStatus= await Order.find({provider_id:jobs[0].provider_id,status:"active"});
            if(checkStatus.length!=0){
                res.status(400).json({error:"You can't have more than one active job at the same time!"});
            }
        }
        const job= await Order.findOneAndUpdate({_id:order_id},
            {
                $set: {status:req.body.status}
            },
            {
                useFindAndModify:true,
            }
              
        );

        res.status(201).json(job);

    }catch(err){
        console.error("Error updating status: ",err);
        
    }
};


const getActiveJob = async (req,res)=>{
    try{

        const jobs= await Order.find({provider_id:req.params.id,status:"active"});
        let lst=[]
        if(jobs.length!=0){
            const toList= async()=>{
                await asyncForEach(jobs,async(job)=>{
                    const findUser = await User.find({_id:job.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:job.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
                    const findReview= await Review.find({order_id:job._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":job,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No active jobs");
        }

    }catch(err){
        console.log("Error finding an active job: ",err)
    }
};

const getPendingJobs = async(req,res)=>{
    try{
        const jobs= await Order.find({provider_id:req.params.id,status:"pending"});
        let lst=[]
        if(jobs.length!=0){
            const toList= async()=>{
                await asyncForEach(jobs,async(job)=>{
                    const findUser = await User.find({_id:job.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:job.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
                
                    const findReview= await Review.find({order_id:job._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return {rating: 0,
                                    }
                        }
                    });
    
                    // const findReview= await Review.find({order_id:job._id},(err,userObj)=>{
                    //     if(err){
                    //         return err
                    //     }else if (userObj){
                    //         return userObj
                    //     }else{
                    //         return null
                    //     }
                    // });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":job,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No pending jobs");
        }
    }catch(err){
        console.log("Error finding pending jobs: ",err);
    }
};

const getDeclinedJobs = async (req,res)=>{
    try{
        const jobs= await Order.find({provider_id:req.params.id,status:"declined"});
        let lst=[]
        if(jobs.length!=0){
            const toList= async()=>{
                await asyncForEach(jobs,async(job)=>{
                    const findUser = await User.find({_id:job.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:job.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    const findReview= await Review.find({order_id:job._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":job,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No declined jobs");
        }
    }catch(err){
        console.log("Error finding declined jobs: ",err);
    }
};

const getCompletedJobs = async (req,res)=>{
    try{
        const jobs= await Order.find({provider_id:req.params.id,is_completed:true});
        let lst=[]
        if(jobs.length!=0){
            const toList= async()=>{
                await asyncForEach(jobs,async(job)=>{
                    const findUser = await User.find({_id:job.seeker_id},(err,userObj)=>{
                                if(err){
                                    return err
                                }else if (userObj){
                                    return userObj
                                }else{
                                    return null
                                }
                            });
    
                    const findProvider= await User.find({_id:job.provider_id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    const findReview= await Review.find({order_id:job._id},(err,userObj)=>{
                        if(err){
                            return err
                        }else if (userObj){
                            return userObj
                        }else{
                            return null
                        }
                    });
    
                    lst.push({
                            "User":JSON.parse(JSON.stringify(findUser))[0],
                            "Provider":JSON.parse(JSON.stringify(findProvider))[0],
                            "Order":job,
                            "Review":JSON.parse(JSON.stringify(findReview))[0]
                        });
    
                    // console.log(lst)
                });
    
                res.status(200).send(lst);
            };
    
            toList();
            
        }
        else{
            res.status(400).send("No completed jobs");
        }
    }catch(err){
        console.log("Error finding completed jobs: ",err);
    }
};

const getOrderByIds = function(req, res){
    const seekerId = req.params.seekerId;// s_id to the requested id
    const providerId = req.params.providerId;

    Order.findOne({seeker_id: seekerId, provider_id: providerId, status: 'pending'})
    .then((order)=>{
        if(!order){
            res.status(200).json({order: ""});
        }
        else
        {res.status(200).json({order: order});}
       
    }).catch((err) => {
        res.json(
            {order: err}
        );
    });
};

module.exports={orderPost,
                ordergetAll, 
                ordergetById, 
                ordergetByOrderId,
                orderDelete,
                orderUpdate,
                ordergetAllCompleted,
                getActiveOrder,
                getPendingOrders,
                getDeclinedOrders,
                getCompletedOrders,
                getAllJobs,
                updateJobStatus,
                getActiveJob,
                getPendingJobs,
                getDeclinedJobs,
                getCompletedJobs,
                getOrderByIds
    
    }; //EXPORT YOUR FUNCTIONS HERE
