# Largest of Three Numbers – DevOps Lab Project

## Aim
To write a Java program to find the largest among three numbers, create a GitHub repository and upload the program using Git, configure a Jenkins Freestyle job to execute the program and build a Docker image, and deploy a sample containerized application using Kubernetes.

---

## 6(a). Write a Program to Find the Largest Among Three Numbers and Upload It to GitHub Using Git

### Step 1: Verify the required software
Open Command Prompt or VS Code Terminal and verify the installations:
```cmd
javac -version
java -version
git --version
```

### Step 2: Open the project folder
Open Visual Studio Code.
Select **File → Open Folder** and choose your folder (`c:\Users\amith\Desktop\Devops`).

### Step 3: Write the Java program
Create a file named `Largest.java` and enter the following code:
```java
import java.util.Scanner;

public class Largest {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter first number: ");
        int num1 = sc.nextInt();

        System.out.print("Enter second number: ");
        int num2 = sc.nextInt();

        System.out.print("Enter third number: ");
        int num3 = sc.nextInt();

        int largest;

        if (num1 >= num2 && num1 >= num3) {
            largest = num1;
        } else if (num2 >= num1 && num2 >= num3) {
            largest = num2;
        } else {
            largest = num3;
        }

        System.out.println("The largest number is: " + largest);

        sc.close();
    }
}
```

### Step 4: Compile and execute the Java program
Open Terminal (**Terminal → New Terminal**) in VS Code and execute:
```cmd
javac Largest.java
java Largest
```
Enter three numbers when prompted (e.g., `15`, `42`, `28`).

### Step 5: Create a GitHub repository
1. Open [https://github.com](https://github.com) and sign in.
2. Click the **+** icon in the top-right corner and select **New repository**.
3. Enter the repository name as `Largest-Project` (or `Devops`).
4. Select **Public**.
5. Leave "Add a README file" unchecked and click **Create repository**.

### Step 6: Upload the Java program using Git
In the terminal, run the following Git commands:
```cmd
git init
git add Largest.java
git commit -m "Initial commit: Largest of three numbers program"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/Largest-Project.git
git push -u origin main
```
*(Replace `YOUR_USERNAME` with your actual GitHub username).*

### Step 7: Verify the GitHub repository
1. Open your GitHub account in a browser.
2. Open the `Largest-Project` repository.
3. Verify that `Largest.java` is visible in the repository.

---

## 6(b). Configure a Jenkins Job, Build Docker Image, and Deploy Using Kubernetes

### Step 8: Create a Dockerfile
In the project folder, create a file named `Dockerfile` (no extension):
```dockerfile
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY Largest.java .
RUN javac Largest.java
CMD ["java", "Largest"]
```

### Step 9: Create Kubernetes deployment file (`deployment.yaml`)
In the project folder, create `deployment.yaml` to deploy a sample Nginx containerized application:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

### Step 10: Add Dockerfile and deployment.yaml to GitHub
Upload the new files so Jenkins can pull them from GitHub:
```cmd
git add Dockerfile deployment.yaml
git commit -m "Add Dockerfile and Kubernetes deployment"
git push origin main
```

### Step 11: Start Docker Desktop
1. Open **Docker Desktop** from the Windows Start menu.
2. Wait until the Docker engine status shows green (**Running**).
3. Verify Docker in Command Prompt:
```cmd
docker --version
docker info
```
*(Optional for Kubernetes)*: In Docker Desktop, go to **Settings → Kubernetes → Check "Enable Kubernetes" → Apply & restart**.

### Step 12: Build and test the Docker image manually
Run the following in the terminal:
```cmd
docker build -t largest-app .
docker images
docker run -it largest-app
```

### Step 13: Create a Jenkins Freestyle job
1. Open your browser and navigate to `http://localhost:8080`.
2. Sign in with your administrator credentials.
3. Click **New Item**.
4. Enter the job name as `Largest-Docker-Job`.
5. Select **Freestyle project** and click **OK**.

### Step 14: Connect Jenkins with GitHub
1. Under **Source Code Management**, select **Git**.
2. In **Repository URL**, enter:
   `https://github.com/YOUR_USERNAME/Largest-Project.git`
3. In **Branch Specifier**, enter: `*/main`.
4. If the repository is public, leave Credentials as **- none -**.

### Step 15: Configure the Jenkins build commands
1. Scroll down to **Build Steps**.
2. Click **Add build step** and choose **Execute Windows batch command**.
3. Enter the following commands:
```cmd
echo ===== Compiling Java Program =====
javac Largest.java

echo ===== Executing Java Program =====
echo 15 42 28 | java Largest

echo ===== Building Docker Image =====
docker build -t largest-app .

echo ===== Listing Docker Images =====
docker images
```
4. Click **Apply** and then **Save**.

### Step 16: Execute the Jenkins job
1. In the Jenkins dashboard, select `Largest-Docker-Job`.
2. Click **Build Now** in the left sidebar.
3. Click on the build number (e.g., `#1`) under **Build History**.
4. Click **Console Output** to view the execution log.
5. Confirm that the Java program compiles, outputs the largest number (`42`), and the Docker image builds successfully.

### Step 17: Deploy sample application using Kubernetes
Open Command Prompt / Terminal in your project folder and run:
```cmd
kubectl apply -f deployment.yaml
```

### Step 18: Verify Kubernetes pods and services
Check the status of the deployed pods and services:
```cmd
kubectl get pods
kubectl get services
```
To access the Nginx welcome page, open your browser and navigate to:
`http://localhost:30080` (or `http://localhost` if using standard port).

---

## Output Screens : Draw Output

### 1. Java Program Compilation & Execution
```
+------------------------------------------------------------+
| C:\Users\amith\Desktop\Devops> javac Largest.java          |
| C:\Users\amith\Desktop\Devops> java Largest                |
| Enter first number: 15                                     |
| Enter second number: 42                                    |
| Enter third number: 28                                     |
| The largest number is: 42                                  |
+------------------------------------------------------------+
```

### 2. Git Commands & Push to GitHub
```
+------------------------------------------------------------+
| C:\Users\amith\Desktop\Devops> git add Largest.java        |
| C:\Users\amith\Desktop\Devops> git commit -m "Initial"     |
| [main f6afee9] Initial commit                              |
| C:\Users\amith\Desktop\Devops> git push -u origin main     |
| Enumerating objects: 4, done.                              |
| Writing objects: 100% (4/4), done.                         |
| To https://github.com/amith/Largest-Project.git            |
|  * [new branch]      main -> main                          |
+------------------------------------------------------------+
```

### 3. Docker Image Build Output
```
+------------------------------------------------------------+
| C:\Users\amith\Desktop\Devops> docker build -t largest-app .|
| [+] Building 1.2s (8/8) FINISHED                           |
|  => [1/3] FROM docker.io/library/eclipse-temurin:21-jdk    |
|  => [2/3] COPY Largest.java .                              |
|  => [3/3] RUN javac Largest.java                           |
|  => exporting to image                                     |
|  => naming to docker.io/library/largest-app                |
+------------------------------------------------------------+
```

### 4. Jenkins Console Output
```
+------------------------------------------------------------+
| Started by user admin                                      |
| Running as SYSTEM                                          |
| Building in workspace C:\ProgramData\Jenkins\.jenkins\...   |
| > git.exe checkout -f origin/main                          |
| [workspace] $ cmd /c call ...                              |
| ===== Compiling Java Program =====                         |
| ===== Executing Java Program =====                         |
| Enter first number: Enter second number: Enter third...    |
| The largest number is: 42                                  |
| ===== Building Docker Image =====                          |
| Successfully tagged largest-app:latest                     |
| Finished: SUCCESS                                          |
+------------------------------------------------------------+
```

### 5. Kubernetes Deployment & Pod Verification
```
+------------------------------------------------------------+
| C:\Users\amith\Desktop\Devops> kubectl apply -f deployment.yaml
| deployment.apps/nginx-deployment created                   |
| service/nginx-service created                              |
|                                                            |
| C:\Users\amith\Desktop\Devops> kubectl get pods            |
| NAME                                READY   STATUS    AGE  |
| nginx-deployment-7798b58df8-k8zlw   1/1     Running   12s  |
|                                                            |
| C:\Users\amith\Desktop\Devops> kubectl get services        |
| NAME            TYPE        CLUSTER-IP     PORT(S)         |
| kubernetes      ClusterIP   10.96.0.1      443/TCP         |
| nginx-service   NodePort    10.108.54.21   80:30080/TCP    |
+------------------------------------------------------------+
```
