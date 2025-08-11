package com.hyprdesk.servicios;

import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;


public class EmailService {
    private static final String HOST_NAME = "smtp.gmail.com";
    private static final int SMTP_PORT = 465;
    private static final String FROM_EMAIL = "hyperdesk.gt@gmail.com"; 
    private static final String FROM_PASSWORD = "kdkb cvwr cpra wddn"; 

    private Email configurarEmail(Email email) throws EmailException {
        email.setHostName(HOST_NAME);
        email.setSmtpPort(SMTP_PORT);
        email.setAuthentication(FROM_EMAIL, FROM_PASSWORD);
        
        // Usar SSL/TLS en la conexión, lo cual es necesario para el puerto 465
        email.setSSLOnConnect(true);
        email.setFrom(FROM_EMAIL);
        return email;
    }
    

    public void enviarCorreoSimple(String toEmail, String subject, String message) {
        try {
            SimpleEmail email = new SimpleEmail();
            configurarEmail(email);
            email.setSubject(subject);
            email.setMsg(message);
            email.addTo(toEmail);
            email.send();
            System.out.println("Correo de confirmación enviado a: " + toEmail);
        } catch (EmailException e) {
            e.printStackTrace();
            System.err.println("Error al enviar el correo a " + toEmail);
        }
    }


    public void enviarCorreoHtml(String toEmail, String subject, String htmlMessage) {
        try {
            HtmlEmail email = new HtmlEmail();
            configurarEmail(email);
            email.setSubject(subject);
            email.setHtmlMsg(htmlMessage);
            email.addTo(toEmail);
            email.send();
            System.out.println("Correo HTML enviado a: " + toEmail);
        } catch (EmailException e) {
            e.printStackTrace();
            System.err.println("Error al enviar el correo HTML a " + toEmail);
        }
    }
    

    public void enviarConfirmacionPedido(String toEmail, String nombreUsuario, int numeroPedido, double totalPedido) {
        String asunto = "Confirmación de tu Pedido #" + numeroPedido;
        String mensaje = "Hola " + nombreUsuario + ",\n\n"
                + "Tu pedido #" + numeroPedido + " ha sido procesado con éxito.\n"
                + "El monto total de tu compra es de: $" + totalPedido + ".\n\n"
                + "¡Gracias por tu compra!\n"
                + "Atentamente,\n"
                + "El equipo de HyprDesk";
        
        enviarCorreoSimple(toEmail, asunto, mensaje);
    }
    

    public void enviarCorreoBienvenida(String toEmail, String nombreUsuario) {
        String asunto = "¡Bienvenido a HyprDesk!";
        String mensaje = "Hola " + nombreUsuario + ",\n\n"
                + "¡Te damos la bienvenida a nuestra comunidad! Gracias por registrarte.\n"
                + "Ahora puedes empezar a explorar nuestros productos y disfrutar de una experiencia de compra única.\n\n"
                + "Atentamente,\n"
                + "El equipo de HyprDesk";
        
        enviarCorreoSimple(toEmail, asunto, mensaje);
    }
    

    public void enviarNotificacionLogin(String toEmail, String nombreUsuario) {
        String asunto = "Actividad de Inicio de Sesión en tu Cuenta";
        String mensaje = "Hola " + nombreUsuario + ",\n\n"
                + "Detectamos un inicio de sesión en tu cuenta de HyprDesk.\n"
                + "Si no fuiste tú, por favor contacta a nuestro soporte inmediatamente.\n\n"
                + "Atentamente,\n"
                + "El equipo de HyprDesk";
        
        enviarCorreoSimple(toEmail, asunto, mensaje);
    }
}
