import java.io.*;
import java.net.Socket;

public class NetworkUtil {
    private Socket socket;
    private BufferedReader bufferedReader;
    private PrintWriter printWriter;
    private DataOutputStream binaryOut;
    private OutputStream out;
    private InputStream inputStream;

    public NetworkUtil(String s, int port) {
        try {
            this.socket = new Socket(s, port);
            this.bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            this.printWriter = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
            this.out = socket.getOutputStream();
        } catch (Exception e) {
            System.out.println("In NetworkUtil : " + e.toString());
            e.printStackTrace();
        }
    }

    public NetworkUtil(Socket s) {
        try {
            this.socket = s;
            this.bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            this.printWriter = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
            this.binaryOut = new DataOutputStream(socket.getOutputStream());
            this.out = socket.getOutputStream();
            this.inputStream = socket.getInputStream();
        } catch (Exception e) {
            System.out.println("In NetworkUtil : " + e.toString());
            e.printStackTrace();
        }
    }

    public String read() {
        String o = null;
        try {
            o = bufferedReader.readLine(); // preferable over readObject
        } catch (Exception e) {
//            System.out.println("Reading Error in network : " + e.toString());
        }
        return o;
    }

    public void writeBrowser(String response) {
        printWriter.write(response);
        printWriter.flush();
    }

    public void writeImageFileOnBrowser(String httpResponse, byte[] imageBytes) {
        try {
            binaryOut.writeBytes("HTTP/1.1 200 OK\r\n");
            binaryOut.writeBytes("Content-Type: image/png\r\n");
            binaryOut.writeBytes("Content-Length: " + imageBytes.length);
            binaryOut.writeBytes("\r\n\r\n");
            binaryOut.write(imageBytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void sendFileForDownload(File fileContent) {
        int count;
        byte[] buffer = new byte[1024];
        try {

            BufferedInputStream in = new BufferedInputStream(new FileInputStream(fileContent));
            while((count=in.read(buffer)) > 0) {
                out.write(buffer, 0, count);
                out.flush();
            }
            in.close();
        } catch(IOException e) {
//            e.printStackTrace();
        }
    }

    public void closeConnection() {
        try {
            bufferedReader.close();
            printWriter.close();
        } catch (Exception e) {
            System.out.println("Closing Error in network : " + e.toString());
        }
    }

    public void writeFromClient(String fileName) {
        printWriter.write("UPLOAD " + fileName + "\r\n");
        printWriter.flush();

        File uploadFile = new File(fileName);

        if (uploadFile.exists()) {
            printWriter.write("valid\r\n");
            printWriter.flush();
            String extension = fileName.split("\\.")[fileName.split("\\.").length-1];
            System.out.println("Valid file. Trying to upload");
            if (extension.equals("jpg") || extension.equals("png") || extension.equals("txt") || extension.equals("mp4")) {
                int count;
                byte[] buffer = new byte[1024];

                try {
                    System.out.println("Sending file");
                    if (socket.isClosed()) {
                        socket = new Socket("localhost", 5038);
                    }
                    BufferedInputStream in = new BufferedInputStream(new FileInputStream(uploadFile));
                    OutputStream out1 = new BufferedOutputStream(socket.getOutputStream());

                    while((count=in.read(buffer)) > 0) {
                        out1.write(buffer, 0, count);
                        out1.flush();
                    }
                    in.close();
                    out1.close();

                    System.out.println("File sent to server");
                } catch(IOException e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println("Invalid file format. File upload failed");
            }

        } else {
            System.out.println("Invalid File");
            printWriter.write("invalid\r\n");
            printWriter.flush();
        }
        closeConnection();
    }

    public void readFileFromClient(FileOutputStream fileOutputStream) {

        System.out.println("Receiving file...");
        long fileSize = 0;
        byte[] buffer = new byte[1024];
        int count = 0;

        try {
            BufferedInputStream in = new BufferedInputStream(socket.getInputStream());
            while((count=in.read(buffer)) > 0) {
                fileOutputStream.write(buffer, 0, count);
                fileOutputStream.flush();
                fileSize += count;
            }

            in.close();

            System.out.println("File received from client");
            System.out.println("File size: " + fileSize);
            printWriter.write("File upload successful");
            printWriter.flush();
            fileOutputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void writeClient(String s) {
        printWriter.write(s);
        printWriter.flush();
    }
}