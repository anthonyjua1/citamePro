//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');

//Función para obtener usuario
async function getUser(req,res){
    try{
        const allUsers = await usuario.find();
        const actualUser = allUsers.filter((nUser)=>nUser.googleId==req.get('googleId'));
        return res.status(200).json( actualUser );
    }catch(e){
        return res.status(404).json('Errorsillo');
    }  
}
async function getAllUser(req,res){
    try{
        const allUsers = await usuario.find();
        const allActiveUsers = allUsers.filter((nUser)=>nUser.googleId!=req.get('googleId'));
        return res.status(200).json( allActiveUsers );
    }catch(e){
        return res.status(404).json('Errorsillo');
    }  
}
//Función para crear usuario
async function postUser(req,res){
    try{
        usuario.findOne({emailUser: req.body.emailUser})
        .then(async (docs)=>{
            if(docs == null){
                console.log('Creando usuario');
                const newUser = usuario({
                    googleId: req.body.googleId,
                    userName: req.body.userName,
                    emailUser: req.body.emailUser,
                    avatar: req.body.avatar,
                });
                newUser.save();
                return res.status(201).json(newUser);
            }else{
                const existingUser = await usuario.findOne({emailUser: req.body.emailUser});
                return res.status(202).json(existingUser);
            }

            
        })
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}


async function updateUser(req,res){

    let emailUsuario = req.body.emailUser

    const usuarioUpdate = {
        userName: req.body.userName
    }

    await usuario.findOneAndUpdate(emailUsuario,{$set:usuarioUpdate},(err,userUpdated)=>{

        if(err){return res.status(404).json('Errosillo');}

        return res.status(200).json({usuario: userUpdated});
    })



}


async function FavoriteBusiness(req,res){
    
    let item = [];
    let previousBusiness  = '';
   

    await usuario.findById(req.body.idUsuario)
    .then((docs)=>{

        previousBusiness = docs.favoriteBusiness;

    });
    const modelo = await business.findById(req.body.idBusiness);
    item = JSON.parse(JSON.stringify(previousBusiness));
    item.push(modelo);

    const mod = {favoriteBusiness: item};

   await usuario.findByIdAndUpdate(req.body.idUsuario, {$set: mod});


    return res.status(200).send('Nitido');


}

async function deleteFavBusiness(req,res){

    

}





//Exportar funciones
module.exports = {
    getUser,
    postUser,
    getAllUser,
    updateUser,
    FavoriteBusiness
}