//import java.io.*;
//import java.net.Socket;
//import java.util.Date;
//import java.util.Scanner;
//
//public class HttpFileServer_2 implements Runnable {
//    public static final String SERVER_DIRECTORY = "D:\\Varsity\\Courses\\3-2\\CSE 322\\Socket Programming";
//    public static final String LOG_DIRECTORY = "D:\\Varsity\\Courses\\3-2\\CSE 322\\Offline 1\\log directory";
//
//    private final Socket clientSocket;
//
//    private BufferedReader bufferedReader;
//    private PrintWriter printWriter;
//
//    private String httpRequest;
//    private String httpResponse = "";
//
//    private final String serverAddress;
//
//    public HttpFileServer_2(Socket clientSocket, String serverAddress) {
//        this.clientSocket = clientSocket;
//        this.serverAddress = serverAddress;
//        Thread thread = new Thread(this);
//        thread.start();
//    }
//
//    @Override
//    public void run() {
//
//        //Initiate buffered reader and print writer with server input stream and output stream
//        try {
//            bufferedReader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
//            printWriter = new PrintWriter(new OutputStreamWriter(clientSocket.getOutputStream()));
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        try {
//            httpRequest = bufferedReader.readLine();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        //HTTP Request Received
//        System.out.println("HTTP REQUEST : " + httpRequest);
//
//        String[] spaceSplitRequest = httpRequest.split(" ");
//        StringBuilder stringBuilder = new StringBuilder();
//        String path = "";
//        String absolutePath = "";
//        File fileContent;
//
//        if (spaceSplitRequest[0].equals("GET")) {
//            // Get request from web browser
//            stringBuilder.append("<html>\n");
//            stringBuilder.append("<head>\n");
//            stringBuilder.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
//            stringBuilder.append("<link rel=\"icon\" href=\"data:,\">\n");
//            stringBuilder.append("</head>\n");
//            stringBuilder.append("<body>\n");
//
//            path = spaceSplitRequest[1];
//            path = path.replaceAll("%20", " ");
//            absolutePath = SERVER_DIRECTORY;
//            String[] pathNames = path.replaceFirst("^/", "").split("/");
//            for (int i = 0; i < pathNames.length; i++) {
//                absolutePath += "\\" + pathNames[i];
//            }
//
//            fileContent = new File(absolutePath);
//
//            if (fileContent.exists()) {
//                //Directory or File exists
//                if (fileContent.isDirectory()) {
//                    //List the directories
//                    for (File files : fileContent.listFiles()) {
//                        if (files.isFile()) {
//                            String temp = "<a href=\"" + path + files.getName() + "\">" + files.getName() + "</a><br>\n";
//                            stringBuilder.append(temp);
//
//                        } else if (files.isDirectory()) {
//                            String temp = "<a href=\"" + path + files.getName() + "/\"><b><i>" + files.getName() + "</i></b></a><br>\n";
//                            stringBuilder.append(temp);
//                        }
//                    }
//                    stringBuilder.append("\n</body>\n</html>");
//                    httpResponse = "HTTP/1.1 200 OK\r\n"
//                            + "Server: Java HTTP Server: 1.0\r\n"
//                            + "Date: " + new Date() + "\r\n"
//                            + "Content-Type: text/html\r\n"
//                            + "Content-Length: " + stringBuilder.toString().length() + "\r\n"
//                            + "\r\n";
//
//                    printWriter.write(httpResponse);
//                    printWriter.write(stringBuilder.toString());
//                    printWriter.flush();
//                } else if (fileContent.isFile()) {
//                    String extension = path.split("\\.")[path.split("\\.").length-1];
//                    if (extension.equals("jpg") || extension.equals("png") || extension.equals("txt") || extension.equals("jpeg")) {
//                        //Show the content in html file
//                        if (extension.equals("txt")) {
//                            //text file
//                            StringBuilder content = new StringBuilder();
//                            try {
//                                Scanner scanner = new Scanner(fileContent);
//                                while (scanner.hasNext()) {
//                                    content.append(scanner.nextLine());
//                                    content.append("<br>\n");
//                                }
//
//                            } catch (Exception e) {
//                                e.printStackTrace();
//                            }
//
//                            stringBuilder.append(content);
//                            stringBuilder.append("\n</body>\n</html>");
//
//                            httpResponse = "HTTP/1.1 200 OK\r\n"
//                                    + "Server: Java HTTP Server: 1.0\r\n"
//                                    + "Date: " + new Date() + "\r\n"
//                                    + "Content-Type: text/html\r\n"
//                                    + "Content-Length: " + stringBuilder.toString().length() + "\r\n"
//                                    + "\r\n";
//
//                            printWriter.write(httpResponse);
//                            printWriter.write("\r\n");
//                            printWriter.write(stringBuilder.toString());
//                            printWriter.flush();
//                        } else {
//
//                            //Image file
//                            FileInputStream fis;
//                            byte[] data = new byte[(int) fileContent.length()];
//                            try {
//                                fis = new FileInputStream(fileContent);
//                                fis.read(data);
//                                fis.close();
//                            } catch (IOException e) {
//                                e.printStackTrace();
//                            }
//                            DataOutputStream binaryOut;
//                            try {
//                                binaryOut = new DataOutputStream(clientSocket.getOutputStream());
//                                binaryOut.writeBytes("HTTP/1.0 200 OK\r\n");
//                                binaryOut.writeBytes("Content-Type: image/png\r\n");
//                                binaryOut.writeBytes("Content-Length: " + data.length);
//                                binaryOut.writeBytes("\r\n\r\n");
//                                binaryOut.write(data);
//
//                                binaryOut.close();
//                            } catch (IOException e) {
//                                e.printStackTrace();
//                            }
//                        }
//
//                    } else {
//                        //Download the file
//                        httpResponse = "HTTP/1.1 200 OK\r\n"
//                                + "Server: Java HTTP Server: 1.0\r\n"
//                                + "Date: " + new Date() + "\r\n"
//                                + "Content-Type: application/force-download\r\n"
//                                + "Content-Length: " + fileContent.length() + "\r\n"
//                                + "Content-Disposition: attachment\r\n"
//                                + "\r\n";
//                        printWriter.write(httpResponse);
//                        printWriter.write("\r\n");
//                        printWriter.flush();
//
//                        int count;
//                        byte[] buffer = new byte[1024];
//                        try {
//                            System.out.println(fileContent.getAbsolutePath());
//                            OutputStream out = clientSocket.getOutputStream();
//                            BufferedInputStream in = new BufferedInputStream(new FileInputStream(fileContent));
//
//                            while((count=in.read(buffer)) > 0) {
//                                out.write(buffer, 0, count);
//                                out.flush();
//                            }
//                            in.close();
//                            out.close();
//                        } catch(IOException e) {
//                            e.printStackTrace();
//                        }
//                    }
//                }
//            } else {
//                //Error 404 not exist
//                stringBuilder.append("Error 404 Not Found\n</body>\n</html>");
//                httpResponse += "HTTP/1.1 404 NOT FOUND\r\n"
//                        + "Server: Java HTTP Server: 1.0\r\n"
//                        + "Date: " + new Date() + "\r\n"
//                        + "Content-Type: text/html\r\n"
//                        + "Content-Length: " + stringBuilder.toString().length() + "\r\n"
//                        + "\r\n";
//
//                printWriter.write(httpResponse);
//                printWriter.write(stringBuilder.toString());
//                printWriter.flush();
//            }
//
//            try {
//                bufferedReader.close();
//                printWriter.close();
//                clientSocket.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//
//
//        } else if (spaceSplitRequest[0].equals("UPLOAD")) {
//            // Upload request from client
//
//            String uploadFileName = httpRequest.substring(7);
//            String validMessage = "";
//
//            try {
//                //Receive validity information
//                validMessage = bufferedReader.readLine();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//
//            if (validMessage.equals("valid")) {
//
//                //Received file is valid
//                byte[] buffer = new byte[1024];
//                int count = 0;
//
//                String extension = uploadFileName.split("\\.")[uploadFileName.split("\\.").length-1];
//
//                if (extension.equals("txt") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png") || extension.equals("mp4")) {
//                    try {
//                        FileOutputStream fileOutputStream = new FileOutputStream(SERVER_DIRECTORY +"\\root\\uploaded\\" + uploadFileName);
//                        DataInputStream in = new DataInputStream(clientSocket.getInputStream());
//                        System.out.println("Receiving file...");
//                        long fileSize = in.readLong();
//
//                        while ( fileSize > 0 && (count = in.read(buffer, 0, (int)Math.min(buffer.length, fileSize))) > 0) {
//                            fileOutputStream.write(buffer, 0, count);
//                            fileSize -= count;
//                        }
//                        System.out.println("File uploaded");
//                        printWriter.write("File upload successful");
//                        printWriter.flush();
//                        in.close();
//                        fileOutputStream.close();
//                    } catch(IOException e) {
//                        e.printStackTrace();
//                    }
//                } else {
//                    System.out.println("Invalid file format. File upload failed");
//                    printWriter.write("Invalid file format. Upload failed");
//                    printWriter.flush();
//                }
//
//            } else if (validMessage.equals("invalid")) {
//                //Received file is invalid
//                System.out.println("Invalid file upload request");
//            }
//
//        } else {
//            //Invalid request
//        }
//    }
//}
