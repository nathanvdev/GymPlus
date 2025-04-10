import { ErrorLog } from "../models/errorLogs";


export const logRequest = (req: any) => {
    const clientIp = req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.ip;
    const formattedIp = clientIp === '::1' ? '127.0.0.1' : clientIp;
    console.log(`[${new Date().toISOString()}] | ${formattedIp} | ${req.originalUrl}`);
}

export const logError = async (error: any, req: any) => {
    const clientIp = req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.ip;
    const formattedIp = clientIp === '::1' ? '127.0.0.1' : clientIp;

    await ErrorLog.create({
        message: error.message,
        source: formattedIp,
        endpoint: req.originalUrl
    });
    
    console.error(`[${new Date().toISOString()}] | ${formattedIp} | ${req.originalUrl} | ${error.message}`);
}
