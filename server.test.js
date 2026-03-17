const request = require('supertest');
const express = require('express');
const path = require('path');


const app = express();
app.use(express.static(path.join(__dirname, 'public')));

describe('Testes do Servidor Node.js', () => {
  test('A rota principal (/) deve retornar status 200 e servir conteúdo HTML', async () => {
    const response = await request(app).get('/');
    
   
    expect(response.statusCode).toBe(200);
    
   
    expect(response.headers['content-type']).toMatch(/text\/html/);
  });
});