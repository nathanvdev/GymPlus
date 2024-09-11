import { Payment } from "../models/payment";
import member from "../models/member";


export const generateMembershipBill = async (payment: typeof Payment.arguments) => {
    const PDFDocument = require(`pdfkit-table`);
    const fs = require(`fs`);
    const doc = new PDFDocument();

    const memberInfo = {
        fullName: `null`,
        idNumber: `0000`,

    };

    const paymentInfo = {
        billing_cyle: 'null',
        initialdate: `null`,
        nextdate: `null`,
        paymentDate: `null`,
        pUnidad: 0.00,
        pTotal: 0.00
    };

    //busca miembro por id 
    await member.findByPk(payment.member_id).then((member) => {
        if (member) {
            memberInfo.fullName = `${member.dataValues.name} ${member.dataValues.last_name}` || 'null';
            memberInfo.idNumber = member.dataValues.id || 'null';
        }

        if (payment.billing_cycle == '1.0') {
            paymentInfo.billing_cyle = '[Gymplus] Membresia Diaria';
            paymentInfo.pUnidad = 5.00;
        } else if (payment.billing_cycle == '2.0') {
            paymentInfo.billing_cyle = '[Gymplus] Membresia Semanal';
            paymentInfo.pUnidad = 10.00;
        } else if (payment.billing_cycle == '3.0') {
            paymentInfo.billing_cyle = '[Gymplus] Membresia Mensual';
            paymentInfo.pUnidad = 100.00;
        } else if (payment.billing_cycle == '4.0') {
            paymentInfo.billing_cyle = '[Gymplus] Membresia Anual';
            paymentInfo.pUnidad = 1000.00;
        }

        paymentInfo.pTotal = parseFloat((payment.billing_quantity * paymentInfo.pUnidad).toFixed(2));


        if (payment.initialpaymentdate) {
            const date = new Date(payment.initialpaymentdate);
            const formattedDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
            paymentInfo.initialdate = formattedDate;
        } else {
            paymentInfo.initialdate = '';
        }

        if (payment.nextpaymentdate) {
            const date = new Date(payment.nextpaymentdate);
            const formattedDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
            paymentInfo.nextdate = formattedDate;
        }
    });

    await member.findByPk(payment.admin_member_id).then((member) => {
        if (member) {
            payment.admin_member_id = `${member.dataValues.name} ${member.dataValues.last_name}` || 'null';
        }
    });


    // Guardar el PDF en un archivo
    doc.pipe(fs.createWriteStream(`./tmp/comprobante_pago.pdf`));

    // Encabezado
    doc.image(`../logo.jpg`, 205, 20, { width: 200, align: `center` }).moveDown(1);

    doc
        .fontSize(12)
        .font(`Times-Roman`).text(`Dirección: ${process.env.GYM_ADDRESS}`, { align: `center` })
        .font(`Times-Roman`).text(`Teléfono: ${process.env.GYM_PHONE}`, { align: `center` })
        .font(`Times-Roman`).text(`Correo: ${process.env.GYM_EMAIL}`, { align: `center` })
        .fontSize(20)
        .font(`Times-Roman`).text('Comprobante de Pago', { align: `center` })

    // Información del miembro
    doc
        .fontSize(14)
        .font(`Times-Roman`).text(`Datos del Miembro`, { underline: true })
        .fontSize(12)
        .font(`Times-Roman`).text(`Nombre Completo: ${memberInfo.fullName}`)
        .font(`Times-Roman`).text(`Número de ID: ${memberInfo.idNumber}`)
        .moveDown(1);

    const table = {
        title: "Datos del Pago",
        headers: ["Cantidad", "Tipo de Pago", "P. Unidad", "Total"],
        rows: [
            [`${payment.billing_quantity}`, `${paymentInfo.billing_cyle}`, `${paymentInfo.pUnidad}`, `${paymentInfo.pTotal}`],
        ],
    };

    // or columnsSize
    await doc.table(table, {
        columnsSize: [50, 320, 50, 50],
    });
    doc.moveDown(1);

    doc.fontSize(9).font(`Times-Roman`).text(`Inicio de Membresia: ${paymentInfo.initialdate}`)
    doc.fontSize(9).font(`Times-Roman`).text(`Fin de Membresia: ${paymentInfo.nextdate}`)
    doc.fontSize(9).font(`Times-Roman`).text(`Metodo de Pago: Efectivo`)
    doc.fontSize(9).font(`Times-Roman`).text(`Efectivo: Q.${payment.cash}`)
    doc.fontSize(9).font(`Times-Roman`).text(`Cambio: Q.${payment.change}`)
    doc.fontSize(9).font(`Times-Roman`).text(`Descripcion del Descuento: \n${payment.discounts_description}`, { align: `justify`, width: 250 })

    doc.fontSize(15).font(`Times-Roman`).text(`Subtotal: Q.${payment.subtotal}`, 320, 300, { align: `right` })
        .fontSize(15).font(`Times-Roman`).text(`Descuentos: Q.${payment.discounts}`, 320, 315, { align: `right`, underline: true })
        .fontSize(15).font(`Times-Roman`).text(`Total: Q.${payment.total}`, 320, 333, { align: `right` })
        .moveDown(6);

    // Pie de página
    //autorizado por:
    doc.fontSize(13).font(`Times-Roman`).text(`Gracias por su preferencia`, 73, 400, { align: `center` });
    doc.moveDown(1);

    const currentDate = new Date();
    const formattedDate = `${currentDate.getFullYear()}-${String(currentDate.getMonth() + 1).padStart(2, '0')}-${String(currentDate.getDate()).padStart(2, '0')}   ${String(currentDate.getHours()).padStart(2, '0')}:${String(currentDate.getMinutes()).padStart(2, '0')}:${String(currentDate.getSeconds()).padStart(2, '0')}`;

    doc.fontSize(7).font(`Times-Roman`).text(`Fecha de emision: ${formattedDate}          No Referencia:${payment.id}          Autorizado por: ${payment.admin_member_id}`, { align: `left` });
    // Finalizar el documento
    doc.end();
}