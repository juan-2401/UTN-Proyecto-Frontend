/* Express y Handlebars */

const express = require('express');
const app = express();
const exphbs = require('express-handlebars');
var helpers = require('handlebars-helpers')();
const sgMail = require('@sendgrid/mail'); /* Sendgrid  */
const bodyParser = require('body-parser'); /* Sendgrid  */

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');
app.use(bodyParser.urlencoded({ extended: true }));

/* DB MySQL Workbench */

var mysql = require('mysql2');
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'webpage2401',
    database: 'adopcion'
});

/* Paginas del Sitio */

    app.use(express.static('public'));

    app.get('/', (req, res) => {
        res.render('index', {title: 'Adopción de Mascotas'});
    });

    app.get('/mascotas', (req, res) => {
        res.render('mascotas', {title: 'Mascotas'});
    });

    app.get('/adoptar', (req, res) => {
        /* Primero se hace el llamado a la DB para traer los datos que se van a renderizar */
        connection.query(
            "SELECT * FROM mascotas WHERE estadomascota = 'En Adopción' ORDER BY nombreMascota ASC;",
            function(err, results) {
                console.log(results);
                res.render('adoptar', {title: 'Adoptar', items: results})
            }
        );
    });

    app.get('/dar-en-adopcion', (req, res) => {
        res.render('dar-en-adopcion', {title: 'Dar en adopción'});
    });

    app.get('/contacto', (req, res) => {
        res.render('contacto', {title: 'Contacto'});
    });

/* SendGrid Adoptar"*/

app.post('/enviar-adoptar', (req, res) => {
    console.log(req.body);
    const { adoptado, nombre, telefono, email } = req.body;

    // using Twilio SendGrid's v3 Node.js Library
    // https://github.com/sendgrid/sendgrid-nodejs
    sgMail.setApiKey('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');
    const msg = {
        to: 'no.reply.240191@gmail.com', // Change to your recipient
        from: 'no.reply.240191@gmail.com', // Change to your verified sender
        subject: `${nombre} quiere adoptar a ${adoptado}`,
        text: 
            `${nombre} quiere adoptar a ${adoptado}.
            Contactalo a su teléfono ${telefono} o a su email ${email}.`
    }
    sgMail
    .send(msg)
    .then(() => {
        console.log('Email sent')
        res.render('formulario-enviado', {title: 'Formulario Enviado'});
    })
    .catch((error) => {
        console.error(error)
    })

    /* Cambio de estado en mascotas a adoptar */

    connection.connect(function(err) {
        if (err) throw err;
        var sql = `UPDATE mascotas SET estadoMascota = 'Por ser adoptada' WHERE nombreMascota = '${adoptado}'`;
        connection.query(sql, function (err, result) {
        if (err) throw err;
        console.log(result.affectedRows + " record(s) updated");
        });
    });

});

/* SendGrid "Dar en Adopción"*/

app.post('/enviar-dar-en-adopcion', (req, res) => {
    console.log(req.body);
    const { nombre, telefono, email, mensaje, zona, animales, años, meses } = req.body;

    // using Twilio SendGrid's v3 Node.js Library
    // https://github.com/sendgrid/sendgrid-nodejs
    sgMail.setApiKey('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');
    const msg = {
        to: 'no.reply.240191@gmail.com', // Change to your recipient
        from: 'no.reply.240191@gmail.com', // Change to your verified sender
        subject: `${nombre} quiere dar un ${animales} en adopción`,
        text: 
            `${nombre} quiere dar un ${animales} en adopción. 
            Zona: ${zona}.
            Edad: ${años} años y ${meses} meses.
            Comentario: ${mensaje}.
            Contactalo a su teléfono ${telefono} o a su email ${email}.`
    }
    sgMail
    .send(msg)
    .then(() => {
        console.log('Email sent')
        res.render('formulario-enviado', {title: 'Formulario Enviado'});
    })
    .catch((error) => {
        console.error(error)
    })
});

/* SendGrid "Contacto"*/

    app.post('/enviar-contacto', (req, res) => {
        console.log(req.body);
        const { nombre, telefono, email, mensaje } = req.body;

        // using Twilio SendGrid's v3 Node.js Library
        // https://github.com/sendgrid/sendgrid-nodejs
        sgMail.setApiKey('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');
        const msg = {
            to: 'no.reply.240191@gmail.com', // Change to your recipient
            from: 'no.reply.240191@gmail.com', // Change to your verified sender
            subject: `${nombre} te ha enviado un mail`,
            text: 
                `${nombre} te envió el siguiente mensaje: ${mensaje}.
                Contactalo a su teléfono ${telefono} o a su email ${email}.`
        }
        sgMail
        .send(msg)
        .then(() => {
            console.log('Email sent')
            res.render('formulario-enviado', {title: 'Formulario Enviado'});
        })
        .catch((error) => {
            console.error(error)
        })
    });

/* Heroku Port */

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
console.log(`Our app is running on port ${ PORT }`);
});