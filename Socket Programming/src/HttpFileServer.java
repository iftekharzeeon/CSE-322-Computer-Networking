
import java.io.*;
import java.util.Date;
import java.util.Scanner;

public class HttpFileServer implements Runnable {
    public static final String SERVER_DIRECTORY = "D:\\Varsity\\Courses\\3-2\\CSE 322\\Socket Programming";
    private File logFiles;

    private Thread thr;
    private final NetworkUtil networkUtil;
    private static int httpRequestCount = 0;

    private String httpResponse = "";

    public HttpFileServer(NetworkUtil networkUtil,File logFiles) {
        this.logFiles = logFiles;
        this.networkUtil = networkUtil;
        this.thr = new Thread(this);
        thr.start();
    }

    @Override
    public void run() {
        try {
            while (true) {
                String httpRequest = networkUtil.read();
                if (httpRequest != null) {

                    String[] spaceSplitRequest = httpRequest.split(" ");
                    StringBuilder stringBuilder = new StringBuilder();
                    String path = "";
                    String absolutePath = "";
                    File fileContent;

                    if (spaceSplitRequest[0].equals("GET")) {
                        //Get request from browser
                        System.out.println("HTTP REQUEST : " + httpRequest);
                        httpRequestCount++;

                        File newLogFile = new File(logFiles.getAbsolutePath() + "\\log_file_" + httpRequestCount + ".txt");
                        FileWriter writeOnFile = new FileWriter(newLogFile);

                        // Get request from web browser
                        stringBuilder.append("<html>\n");
                        stringBuilder.append("<head>\n");
                        stringBuilder.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
                        stringBuilder.append("<link rel=\"icon\" href=\"data:,\">\n");
                        stringBuilder.append("</head>\n");
                        stringBuilder.append("<body>\n");

                        path = spaceSplitRequest[1];
                        path = path.replaceAll("%20", " ");
                        absolutePath = SERVER_DIRECTORY;
                        String[] pathNames = path.replaceFirst("^/", "").split("/");
                        for (int i = 0; i < pathNames.length; i++) {
                            absolutePath += "\\" + pathNames[i];
                        }

                        fileContent = new File(absolutePath);

                        writeOnFile.write(httpRequest);
                        writeOnFile.append("\n");
                        writeOnFile.append("--------------------------");
                        writeOnFile.append("\n");

                        if (fileContent.exists()) {
                            //Directory or File exists
                            if (fileContent.isDirectory()) {
                                //List the directories
                                for (File files : fileContent.listFiles()) {
                                    if (files.isFile()) {
                                        String temp = "<a href=\"" + path + files.getName() + "\">" + files.getName() + "</a><br>\n";
                                        stringBuilder.append(temp);

                                    } else if (files.isDirectory()) {
                                        String temp = "<a href=\"" + path + files.getName() + "/\"><b><i>" + files.getName() + "</i></b></a><br>\n";
                                        stringBuilder.append(temp);
                                    }
                                }
                                stringBuilder.append("\n</body>\n</html>");
                                httpResponse = "HTTP/1.1 200 OK\r\n"
                                        + "Server: Java HTTP Server: 1.0\r\n"
                                        + "Date: " + new Date() + "\r\n"
                                        + "Content-Type: text/html\r\n"
                                        + "Content-Length: " + stringBuilder.toString().length() + "\r\n"
                                        + "\r\n";

                                writeOnFile.append(httpResponse);
                                networkUtil.writeBrowser(httpResponse);
                                networkUtil.writeBrowser(stringBuilder.toString());
                            } else if (fileContent.isFile()) {
                                String extension = path.split("\\.")[path.split("\\.").length-1];
                                if (extension.equals("jpg") || extension.equals("png") || extension.equals("txt") || extension.equals("jpeg")) {
                                    //Show the content in html file
                                    if (extension.equals("txt")) {
                                        //text file
                                        StringBuilder content = new StringBuilder();
                                        try {
                                            Scanner scanner = new Scanner(fileContent);
                                            while (scanner.hasNext()) {
                                                content.append(scanner.nextLine());
                                                content.append("<br>\n");
                                            }

                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }

                                        stringBuilder.append(content);
                                        stringBuilder.append("\n</body>\n</html>");

                                        httpResponse = "HTTP/1.1 200 OK\r\n"
                                                + "Server: Java HTTP Server: 1.0\r\n"
                                                + "Date: " + new Date() + "\r\n"
                                                + "Content-Type: text/html\r\n"
                                                + "Content-Length: " + stringBuilder.toString().length() + "\r\n"
                                                + "\r\n";

                                        writeOnFile.append(httpResponse);
                                        networkUtil.writeBrowser(httpResponse + "\r\n");
                                        networkUtil.writeBrowser(stringBuilder.toString());
                                    } else {
                                        //Image file
                                        FileInputStream fis;
                                        byte[] data = new byte[(int) fileContent.length()];
                                        try {
                                            fis = new FileInputStream(fileContent);
                                            fis.read(data);
                                            fis.close();
                                        } catch (IOException e) {
                                            e.printStackTrace();
                                        }
                                        httpResponse = "HTTP/1.1 200 OK\r\n"
                                                + "Server: Java HTTP Server: 1.0\r\n"
                                                + "Date: " + new Date() + "\r\n"
                                                + "Content-Type: image/png\r\n"
                                                + "Content-Length: " + data.length + "\r\n"
                                                + "\r\n";
                                        writeOnFile.append(httpResponse);
                                        networkUtil.writeImageFileOnBrowser(httpResponse,data);
                                    }

                                } else {
                                    //Download the file
                                    httpResponse = "HTTP/1.1 200 OK\r\n"
                                            + "Server: Java HTTP Server: 1.0\r\n"
                                            + "Date: " + new Date() + "\r\n"
                                            + "Content-Type: application/force-download\r\n"
                                            + "Content-Length: " + fileContent.length() + "\r\n"
                                            + "Content-Disposition: attachment\r\n"
                                            + "\r\n";
                                    writeOnFile.append(httpResponse);
                                    networkUtil.writeBrowser(httpResponse + "\r\n");
                                    networkUtil.sendFileForDownload(fileContent);
                                }
                            }

                        } else {
                            //Error 404 not exist
                            stringBuilder.append("Error 404 Not Found\n</body>\n</html>");
                            httpResponse += "HTTP/1.1 404 NOT FOUND\r\n"
                                    + "Server: Java HTTP Server: 1.0\r\n"
                                    + "Date: " + new Date() + "\r\n"
                                    + "Content-Type: text/html\r\n"
                                    + "Content-Length: " + stringBuilder.toString().length() + "\r\n"
                                    + "\r\n";

                            writeOnFile.append(httpResponse);
                            networkUtil.writeBrowser(httpResponse + "\r\n");
                        }
                        writeOnFile.close();
                    } else if (spaceSplitRequest[0].equals("UPLOAD")) {
                        System.out.println("HTTP REQUEST : " + httpRequest);
                        //Upload request from client

                        String uploadFileName = httpRequest.substring(7);
                        String validMessage = "";

                        //Receive validity information
                        validMessage = networkUtil.read();

                        if (validMessage.equals("valid")) {

                            //Received file is valid
                            String extension = uploadFileName.split("\\.")[uploadFileName.split("\\.").length-1];

                            if (extension.equals("txt") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png") || extension.equals("mp4")) {
                                try {
                                    FileOutputStream fileOutputStream = new FileOutputStream(SERVER_DIRECTORY +"\\root\\uploaded\\" + uploadFileName);
                                    networkUtil.readFileFromClient(fileOutputStream);
                                    break;

                                } catch(IOException e) {
                                    e.printStackTrace();
                                }
                            } else {
                                System.out.println("Invalid file format. File upload failed");
                                networkUtil.writeClient("Invalid file format. Upload failed");
                            }

                        } else if (validMessage.equals("invalid")) {
                            //Received file is invalid
                            System.out.println("Invalid file for upload request");
                        }
                    } else {
                        //Invalid request

                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            networkUtil.closeConnection();
        }
    }
}
