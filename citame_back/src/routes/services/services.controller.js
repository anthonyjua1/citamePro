//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const services = require('../../models/services.model.js');

async function getServices(req,res){
    
    try{
        let item = [];
        let servicioSend = [];
        let contador = 0;
        await business.findById(req.get('idBusiness'))
            .then(async(docs)=>{
                    
                    const servicios = docs.servicios;
                    item = JSON.parse(JSON.stringify(servicios));
                

        
            }).catch(e=>console.log(e));

            item.forEach(async (element)  =>  {
                const servicio = await services.findById(element)

                servicioSend.push(servicio);
                contador++;

                if (contador == item.length){
                    return res.status(200).json(servicioSend);
                }

            });

            

    }catch(e){
        return res.status(404).json('Errosillo');
    }  


}

async function postServices(req,res){

    try{
        
        business.findById(req.body.idBusiness)
        .then(async (docs)=>{
            if(docs != null){
                console.log('Creando Servicio');


                const servicioNew = new services({
                    nombreServicio: req.body.nombreServicio,
                    businessCreatedBy : docs._id,
                    precio: req.body.precio,
                    imgPath: req.body.imgPath,
                    descripcion: req.body.descripcion})


                await servicioNew.save();
                
                return res.status(201).send(servicioNew);
            }
            return res.status(202).send({'sms': 'El Servicio ya existe'});//Cambiar porque est[a raro]
        });
    }catch(e){
        return res.status(404).json('Errosillo');
    }  

};

async function deleteService(req,res){

};

async function updateService(req,res){

};

module.exports = {
    getServices,
    postServices,
    deleteService,
    updateService
}