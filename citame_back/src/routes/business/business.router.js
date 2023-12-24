const express = require('express');
//Importación de funciones
const { getAllBusiness,getOwnerBusiness, 
    postBusiness, verifyOwnerBusiness, 
    deleteBusiness, updateWorkersInBusinessbyCreateWorker,
    updateWorkers,updateArrayServices,updateBusiness, getFavBusiness } = require('./business.controller.js');

const {verifyBusinessToken} = require('../Auth/verifyToken.js')
//Creación de enrutador
const businessRouter = express.Router();
//Asignación de direcciones
businessRouter.get('/api/business/get/all',getAllBusiness);
businessRouter.get('/api/business/get/owner',getOwnerBusiness);
businessRouter.post('/api/business/create',postBusiness);
businessRouter.post('/api/business/verify/owner/business',verifyOwnerBusiness);
businessRouter.delete('/api/business/delete',verifyBusinessToken,deleteBusiness);
businessRouter.put('/api/business/update',updateWorkersInBusinessbyCreateWorker);
businessRouter.put('/api/business/workerupdate',updateWorkers);
businessRouter.put('/api/business/serviceupdate',updateArrayServices);
businessRouter.put('/api/business/updateBusiness',updateBusiness);
businessRouter.get('/api/business/FavBusiness',getFavBusiness);

//Exportar enrutador
module.exports = businessRouter;