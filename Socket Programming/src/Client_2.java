//import java.io.*;
//import java.net.Socket;
//
//public class Client_2 implements Runnable {
//
//    private String fileName;
//    private Socket socket;
//
//    private BufferedReader bufferedReader;
//    private DataOutputStream out;
//
//    PrintWriter printWriter;
//    public Client_2(String input, Socket socket, PrintWriter printWriter, BufferedReader bufferedReader, DataOutputStream out) {
//        this.fileName = input;
//        this.socket = socket;
//        this.printWriter = printWriter;
//        this.bufferedReader = bufferedReader;
//        this.out = out;
//        Thread thread = new Thread(this);
//        thread.start();
//    }
//
//    @Override
//    public void run() {
//
//        printWriter.write("UPLOAD " + fileName + "\r\n");
//        printWriter.flush();
//
//        File uploadFile = new File(fileName);
//
//        if (uploadFile.exists()) {
//            printWriter.write("valid\r\n");
//            printWriter.flush();
//            System.out.println("Valid file. Trying to upload");
//
//            int count;
//            byte[] buffer = new byte[1024];
//
//            try {
//                System.out.println("Sending file");
//                BufferedInputStream in = new BufferedInputStream(new FileInputStream(uploadFile));
//
//                //Sending file size first
//                out.writeLong(uploadFile.length());
//
//                while((count=in.read(buffer)) > 0) {
//                    out.write(buffer, 0, count);
//                    out.flush();
//                }
//
//                System.out.println("File sent to server");
//
//                String respondMessage = bufferedReader.readLine();
//                System.out.println("FROM SERVER: " + respondMessage);
//
//                in.close();
//            } catch(IOException e) {
//                e.printStackTrace();
//            }
//        } else {
//            printWriter.write("invalid\r\n");
//            printWriter.flush();
//            System.out.println("Invalid File");
//        }
//    }
//}
