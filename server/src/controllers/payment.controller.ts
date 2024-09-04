import { Request, Response } from "express";
import { Payment } from "../models/payment";
import { generateMembershipBill } from "../utilities/membership_bill";
import member from "../models/member";

export const postpayment = async (req: Request, res: Response) => {

    const { body } = req;

    try {
        if (body.cash == '') {
            body.cash = body.total;
            body.change = 0;
        }

        const newPayment = await Payment.create(body);
        const bill = newPayment.toJSON();
        console.log(typeof bill);
        await generateMembershipBill(bill);

        res.status(200).json({
            msg: 'Pago creado',
            newPayment
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }

}

export const getBill = async (_: Request, res: Response) => {

    try {
        const PDFDocument = require('pdfkit-table');
        const fs = require('fs');
        const doc = new PDFDocument();

        const gymInfo = {
            name: 'Comprobante de Pago',
            address: '123 Calle Principal, Ciudad, País',
            phone: '+1234567890',
            email: 'contacto@gymplus.com'
        };

        const memberInfo = {
            fullName: 'John Doe',
            idNumber: '123456'
        };



        // Guardar el PDF en un archivo
        doc.pipe(fs.createWriteStream('comprobante_pago.pdf'));

        // Encabezado
        doc.image('../logo.jpg', 205, 20, { width: 200, align: 'center' }).moveDown(1);

        doc
            .fontSize(12)
            .font('Times-Roman').text(`Dirección: ${gymInfo.address}`, { align: 'center' })
            .font('Times-Roman').text(`Teléfono: ${gymInfo.phone}`, { align: 'center' })
            .font('Times-Roman').text(`Correo: ${gymInfo.email}`, { align: 'center' })
            .fontSize(20)
            .font('Times-Roman').text(gymInfo.name, { align: 'center' })

        // Información del miembro
        doc
            .fontSize(14)
            .font('Times-Roman').text('Datos del Miembro', { underline: true })
            .moveDown(0.5)
            .fontSize(12)
            .font('Times-Roman').text(`Nombre Completo: ${memberInfo.fullName}`)
            .font('Times-Roman').text(`Número de ID: ${memberInfo.idNumber}`)
            .moveDown(1);

        const table = {
            title: "Datos del Pago",
            headers: ["Cantidad", "Tipo de Pago", "P. Unidad", "Total"],
            rows: [
                ["2", "Mensual", "100.00", "200.00"],
            ],
        };

        // or columnsSize
        await doc.table(table, {
            columnsSize: [50, 320, 50, 50],
        });
        doc.moveDown(1);

        doc.font('Times-Roman').text('Inicio de Membresia: 2023-01-01')
        doc.font('Times-Roman').text('Fin de Membresia: 2023-03-01')
        doc.font('Times-Roman').text('Metodo de Pago: Efectivo')
        doc.font('Times-Roman').text('Efectivo: Q.500.00')
        doc.font('Times-Roman').text('Cambio: Q.320.00')
        doc.font('Times-Roman').text('Descripcion del Descuento: \nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur', { align: 'justify', width: 300 })

        doc.fontSize(15).font('Times-Roman').text('Subtotal: Q.200.00', 320, 300, { align: 'right' })
            .fontSize(15).font('Times-Roman').text('Descuentos: Q.20.00', 320, 315, { align: 'right', underline: true })
            .fontSize(15).font('Times-Roman').text('Total: Q.180.00', 320, 333, { align: 'right' })
            .moveDown(6);

        // Pie de página
        //autorizado por:
        doc.fontSize(7).font('Times-Roman').text('Fecha de emision: 2024-07-23     No Referencia: 123434-23        Autorizado por: admin', 73, 390, { align: 'left' });
        doc.moveDown(1);
        doc.fontSize(13).font('Times-Roman').text('Gracias por su preferencia', { align: 'center' });

        // Finalizar el documento
        doc.end();

        res.status(200).json({
            msg: 'Factura creada'
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });

    }

}


export const getPayments = async (_: Request, res: Response) => {
    try {
        const payments = await Payment.findAll();

        const paymentsWithMemberInfo = await Promise.all(payments.map(async (payment) => {
            const tmp = await member.findByPk(payment.dataValues.member_id);
            return {
                ...payment.toJSON(),
                member_name: tmp ? tmp.dataValues.name : 'N/A',
                member_lastname: tmp ? tmp.dataValues.last_name : 'N/A'
            };
        }));


        res.status(200).json({
            msg: 'Pagos',
            payments: paymentsWithMemberInfo
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }
};

export const getPaymentById = async (req: Request, res: Response) => {

    const { id } = req.params;

    try {
        const payment = await Payment.findByPk(id);

        if (!payment) {
            return res.status(404).json({
                msg: 'Pago no encontrado'
            });
        }

        const memberInfo = await member.findByPk(payment.dataValues.member_id);
        payment.dataValues.member_name = memberInfo ? memberInfo.dataValues.name : 'N/A';
        payment.dataValues.member_lastname = memberInfo ? memberInfo.dataValues.last_name : 'N/A';
        res.status(200).json({
            payment
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }
};


export const updatePayment = async (req: Request, res: Response) => {

    const { body } = req;

    try {

        const payment = await Payment.findByPk(req.params.id);

        if (!payment) {
            return res.status(404).json({
                msg: 'Pago no encontrado'
            });
        }
        const updatedPayment ={
            membership_plan: body.membership_plan,
            billing_quantity: body.billing_quantity,
            billing_cycle: body.billing_cycle,
            initialpaymentdate: body.initialpaymentdate,
            nextpaymentdate: body.nextpaymentdate,
            subtotal: body.subtotal,
            discounts: body.discounts,
            discounts_description: body.discounts_description,
            total: body.total,
            payment_method: body.payment_method,
            cash: body.cash,
            change: body.change,
            payment_status: body.payment_status,
            payment_reference: body.payment_reference,
        }
        await payment.update(updatedPayment);

        res.status(200).send({ "msg": "Pago actualizado" });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }
}