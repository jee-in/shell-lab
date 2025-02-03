# Unix Shell Lab
Unix Shell Lab은 Carnegie Mellon University의 강의 `15-213 Introduction to Computer Systems`에서 제공하는 Lab으로, 간단한 Unix shell 프로그램을 만들어보는 과제입니다.   
Unix Shell Lab 과제의 목표는 교재 `CS:APP (Computer System: As a Programmer's Perspective)` '8장 예외적인 제어 흐름'에서 다루는 **프로세스 제어** 그리고 **시그널링** 개념과 친숙해지는 것입니다.

아래 페이지에서 과제를 수행하는 데 필요한 소스 파일과 과제 안내서를 확인할 수 있습니다.
- Lab 목록: [https://csapp.cs.cmu.edu/3e/labs.html](https://csapp.cs.cmu.edu/3e/labs.html) 
- Shell Lab 과제 안내서: [https://csapp.cs.cmu.edu/3e/shlab.pdf](https://csapp.cs.cmu.edu/3e/shlab.pdf) / [[한글 번역]](https://manythreedays.tistory.com/144)

## 과제 요구 사항
과제 파일에 있는 tsh.c (tiny shell) 에 Unix shell의 골격이 제공되어 있습니다.  
비어 있는 다음 함수들을 완성하세요. (괄호 안의 숫자는 해당 함수의 대략적인 코드 라인 수입니다.)

1. `eval`: 커맨드 라인을 파싱하고 해석하는 메인 루틴
2. `builtin_cmd`: 내장 명령어 quit, fg, bg, jobs 를 인식하고 해석하여 실행 [25줄]
3. `do_bgfg`: 내장 명령어 bg와 fg를 구현 [50줄]
4. `waitfg`: foreground job이 끝나기를 기다리기 [20줄]
5. `sigchld_handler`: SIGCHILD 시그널을 catch하기 [80줄]
6. `sigint_handler`: SIGINT (ctrl-c) 시그널을 catch하기 [15줄]
7. `sigtstp_handler`: SIGTSTP (ctrl-z) 시그널을 catch하기 [15줄]

## `Makefile` 업데이트
빌드 및 테스트 자동화를 위해 `Makefile`을 이용합니다. 기존 `Makefile`을 통해 제공되는 make 명령어는 다음과 같습니다.
- `make`
  -  `tsh.c` 와 테스트용 프로그램 (`myint.c`, `myspin.c`, `mysplit.c`, `mystop.c`)을 빌드
-  `make test01` / `make rtest01` 
    - `tsh` / 레퍼런스 shell 실행 파일인 `tshref`의 테스트 결과 출력 (test01 ~ test16에 적용 가능)
- `make clean`
    - 빌드 파일 삭제

과제를 수행하는 과정에서 다음과 같이 `Makefile`을 수정하였습니다.  
-  `tsh` 빌드 방법 수정
    - `tsh.c`를 컴파일하는 gcc 명령어에 라이브러리의 헤더 파일 및 소스 파일 경로 추가. (시그널 핸들러에서 안전하게 사용할 수 있는 async-safe 버전의 입출력 라이브러리 `sio.c` (교재 CS:APP에서 제공) 를 추가함)
 - 타켓 추가
   - `tsh`와 `tshref`의 출력 결과를 파일에 저장하는 make 명령어 추가
   - `tsh`와 `tshref`의 출력 결과를 비교하는 make 명령어 추가 
 - `make clean` 업데이트
    - 테스트 결과 생성된 파일도 삭제

## Tiny Shell 실행 및 테스트 방법
업데이트된 `Makefile`을 통해 사용할 수 있는 make 명령어들은 다음과 같습니다. 이 명령어들을 이용하여 Tiny shell을 실행하고 테스트할 수 있습니다.

### 1. `make`
`tsh.c`에 구현한 Tiny Shell을 실행하고, 테스트를 진행하기 위해서는 `make` 명령어를 통해 소스 코드를 실행 가능한 파일로 빌드해야 합니다. `make` 명령어는`tsh.c` 파일과 테스트용 프로그램인 `myint.c`, `myspin.c`, `mysplit.c`, `mystop.c`을 빌드하는 명령어입니다.

```Shell
# make를 입력하면 수행되는 명령어 예시
gcc -Wall -O2  -I./include   tsh.c  lib/sio.c   -o tsh 
gcc -Wall -O2                myspin.c           -o myspin
```

빌드를 마친 후 커맨드 라인에 `./tsh`를 입력하면 `tsh.c`에 구현한 shell 프로그램을 실행시킬 수 있습니다.
```Shell
./tsh
```

### 2. `make test01` / `make rtest01`
테스트 드라이버 파일 `sdriver.pl`이 `tsh` / `tshref` (레퍼런스 Shell 실행 파일)에서 테스트 케이스인 `trace01`~`trace16`을 실행시키게 만드는 명령어입니다. `tsh.c`를 올바르게 잘 작성했는지 확인하기 위해 사용합니다.

```Shell
# make test01 을 입력하면 수행되는 명령어 예시
./sdriver.pl -t trace01.txt -s ./tsh    -a "-p"

# make rtest01을 입력하면 수행되는 명령어 예시
./sdriver.pl -t trace01.txt -s ./tshref -a "-p"
```

단, 두 명령어의 출력 결과에서 PID나 파일 경로는 다를 수 있습니다. 또한 test11과 test12는 `'/bin/ps -a` 명령어를 실행시켜 시스템의 전체 프로세스를 출력시키는데 이때의 두 출력 결과도 동일하지 않을 수 있습니다.

### 3. `make test01.result`, `make rtest01.result`
`make test01` / `make rtest01`의 출력 결과를 터미널로 출력하지 않고 파일에 저장하는 명령어입니다.
```Shell
# make test01.result 을 입력하면 수행되는 명령어 예시
make test01.result > ./test01.result

# make rtest01.result을 입력하면 수행되는 명령어 예시
make rtest01.result > ./rtest01.result
```

### 4. `make test01.diff`
`make test01.result`과 `make rtest01.result`를 실행시킨 뒤 출력 결과인 `./test01.result`과 `./rtest01.result`의 차이를 터미널에 출력하는 명령어입니다. 
```Shell
# make test01.diff를 입력하면 수행되는 명령어 예시
diff -u ./rtest01.result ./test01.result || (echo "$(MSG)"; exit 0)
```
터미널 출력 결과를 파일로 리다이렉션하고 싶다면 커맨드 라인에 다음과 같이 입력하면 됩니다.
```Shell
make test01.diff > test01.diff
```

### 5. `make tests.result`, `make rtests.result`
모든 테스트의 출력 결과를 하나의 파일에서 모아 보고 싶을 때 사용하는 명령어입니다.  
`tsh`에서의 테스트 실행 결과와 `tshref`에서의 테스트 실행 결과는 각각 `tests.result`와 `rtests.result`에 저장됩니다.

### 6. `make tests.diff`
`make tests.result`, `make rtests.result`를 실행시킨 뒤 출력 결과인 `tests.result`와 `rtests.result`의 차이를 파일 `tests.diff`에 저장하는 명령어입니다.

### 7. `make clean`
프로젝트 홈 디렉토리에 있는 빌드 파일과 테스트 결과가 저장된 파일을 삭제하는 명령어입니다.

## 과제 수행 일지

### 1. 함수 `eval` 구현하기  

  [ ✔️ ] 커맨드 라인을 파싱하는 함수 `parseline` 을 호출한다.  
  - `parseline` 수정 사항: single quote 에러 핸들링 코드 추가  

  [ ✔️ ] `parseline`의 리턴 값에 따라 프로세스의 foreground / background 실행 여부 결정  

  [ ✔️ ] "&" 여부에 따라 foreground에서 실행할지 background에서 실행할지 결정한다.

  [ ✔️ ] `sigprocmask` 함수에 전달할 시그널 마스크 생성 (&mask_all, &mask_one)

  [ ✔️ ] 커맨드 라인의 첫 번째 단어가 내장 명령어인지 확인하는 함수 `builtin_cmd` 호출

  [ ✔️ ] 커맨드 라인의 첫 번째 단어가 내장 명령어가 아니라면, 이를 실행 가능한 파일의 경로 이름으로 간주하고 실행한다.

  [ ✔️ ] 자식 프로세스를 `fork` 하고 `execve` 한다.

  ```C
  /* Block SIGCHILD */
  if (sigprocmask(SIG_BLOCK, &mask_one, &prev_one) < 0)
      unix_error ("Sigprocmask error");

  /* Parent creates child */
  if ((pid = fork()) < 0) {
      unix_error ("Fork error");
  } else if (pid == 0) {  
      /* Child process restore blocked set before execution*/
      if (sigprocmask(SIG_SETMASK, &prev_one, NULL) < 0)
          unix_error("Sigprocmask error");
      /* Set unique process group ID */
      setpgid (0, 0);
      /* Child executes */
      if (execve(argv[0], argv, environ) < 0) {
          fprintf (stderr, "%s: Command not found\n", argv[0]);
      }
  }

  /* Block All signals before accessing global data structure*/
  if (sigprocmask(SIG_BLOCK, &mask_all, NULL) < 0)
      unix_error ("Sigprocmask error");
  /* Add child process (job) to job list */
  addjob(jobs, pid, state, cmdline);
  jid = getjobpid(jobs, pid)->jid;
  /* Restore blocked set */
  if (sigprocmask(SIG_SETMASK, &prev_one, NULL) < 0)  /* Restore blocked set */
      unix_error ("Sigprocmask error");

  /* Parent waits for foreground job to terminate */
  if (!bg)
      waitfg(pid);
  else
      printf("[%d] (%d) %s", jid, pid, cmdline);
  ```

  - `sigchld_handler`의 `deletejob`과 부모 프로세스의 `addjob` 사이에 race condition (동기화 에러) 이 발생할 수 있다. 이를 제거하기 위해 부모 프로세스가 자식 프로세스를 생성 (`fork`)하여 `addjob`하기 전에 `sigchld_handler`가 호출되어 `deletejob`을 하지 않도록 `SIGCHLD` 시그널을 차단한다.
  - 자식 프로세스는 실행 전에 부모 프로세스로부터 물려받은 blocked set (`SIGCHLD가 차단된 상태`)를 원래대로 복구한다.
  - 자식 프로세스를 고유한 프로세스 그룹에 넣는다. 이는 ./tsh의 프로세스 그룹과 자식 프로세스 그룹을 구분하여 자식 프로세스가 `ctrl-c`의 영향을 직접적으로 받지 않도록 하기 위함이다.
  - 부모 프로세스는 `addjob`을 하기 전후로 모든 시그널을 차단하여 전역 자료 구조의 동기화 에러를 방지한다.
  - foreground에서 프로세스를 실행할 경우 프로세스가 종료/중단/백그라운드로 이동할 때까지 sleep한다.

### 2. 함수 builtin-cmd 구현하기
```C
int builtin_cmd(char **argv) 
{
    sigset_t mask_all, prev_one;
    if (sigfillset(&mask_all) < 0)
        unix_error ("Sigfillset error");

    if (!strcmp(argv[0], "quit"))
        exit(0);
    if (!strcmp(argv[0], "fg") || !strcmp(argv[0], "bg")) {
        do_bgfg(argv);
        return 0;
    }
    if (!strcmp(argv[0], "jobs")) {
        /* Block all signals before accessing global data structure */
        if (sigprocmask(SIG_BLOCK, &mask_all, &prev_one) < 0)
            unix_error ("Sigprocmask error");
        listjobs (jobs);
        /* Restore blocked set */
        if (sigprocmask(SIG_SETMASK, &prev_one, NULL) < 0)
            unix_error ("Sigprocmask error");
        return 0;
    }
    return 1;     /* not a builtin command */
}
```

### 3. 함수 do_bgfg 구현하기  
 [ ✔️ ] `fg` 또는 `bg` 다음에 `%{JID}`가 오는지 `{PID}`가 오는지 확인하여 적절히 처리하기  
 [ ✔️ ]  명령어에 따라 job의 상태 바꾸기
  ```C
  /* Block all signals before accessing global data structure */
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_one) < 0)
        unix_error ("Sigprocmask error");
    /* Change state of job */
    job->state = (!strcmp(argv[0], "fg")) ? FG : BG;

    /* Send SIGCONT signal to process */
    if (kill(-pid, SIGCONT) < 0)
        unix_error("Kill (SIGCONT) error");

    if (job->state == FG) {
        /* Restore blocked set after checking global data structure */
        if (sigprocmask(SIG_SETMASK, &prev_one, NULL) < 0)
            unix_error ("Sigprocmask error");
        /* Waits for foreground job to terminate */
        waitfg(pid);
    } else {
          /* Restore blocked set after checking global data structure */
        if (sigprocmask(SIG_SETMASK, &prev_one, NULL) < 0)
            unix_error ("Sigprocmask error");
        printf("[%d] (%d) %s", job->jid, job->pid, job->cmdline);
    }
  ```
  - 전역 자료 구조 `jobs`에 접근하기 전에 모든 시그널을 차단한다.
  - 재시작하고 싶은 프로세스에 `kill` 명령어를 이용하여 `SIGCONT` 시그널을 전송한다. 이때 `-pid` 인자를 이용하여 해당 프로세스 그룹에 속한 모든 프로세스에게 시그널을 전송한다.


### 4. 함수 waitfg 구현하기  
[ ✔️ ] `SIGCHLD` 시그널을 차단한 채로 job이 foreground에서 실행 중인지 while 문으로 확인한다.  
[ ✔️ ] job이 foreground에서 실행 중이라면 시그널이 올 때까지 sleep한다. (일시적으로 `SIGCHLD` 차단 해제)

```C
void waitfg(pid_t pid)
{
    struct job_t *job;
    sigset_t mask_one, prev_one;

    sigemptyset(&mask_one);
    sigaddset(&mask_one, SIGCHLD);

    /* Block SIGCHLD signal  */
    if (sigprocmask(SIG_BLOCK, &mask_one, &prev_one) < 0)
        unix_error ("Sigprocmask error");  
    while (job->state == FG) {
        /* Unblock SIGCHLD temporarily */
        sigsuspend(&prev_one);
    }
    /* Restore blocked set */
    if (sigprocmask(SIG_SETMASK, &prev_one, NULL) < 0)
        unix_error ("Sigprocmask error");

    return;
}
```

### 5. 함수 sigchld_handler 구현하기
[ ✔️ ] 안전한 시그널 핸들링을 위해 시그널 핸들링 함수가 시작할 때 `errno`를 저장해놨다가 리턴하기 전에 복구한다.  
[ ✔️ ] 안전한 시그널 핸들링을 위해 시그널 핸들링 함수에서는 async-safe-function을 이용한다. (`printf` 사용 지양)  
[ ✔️ ] 안전한 시그널 핸들링을 위해 전역 자료 구조 `jobs`에 접근하기 전에 모든 시그널을 차단한다.   
[ ✔️ ] `waitpid`를 `WNOHANG`과 `WUNTRACED` 옵션과 함께 호출하여 비동기적으로, 프로세스의 종료/중단 여부를 확인한다.  
[ ✔️ ] 정상/비정상 종료 프로세스는 `deletejob`으로 `jobs`에서 삭제한다.  
[ ✔️ ] 중단 프로세스는 job의 상태를 업데이트한다. 

```C
void sigchld_handler(int sig) 
{
    int olderrno = errno;           /* Store errno */
    sigset_t mask_all, prev_all;
    pid_t pid;
    int status;
    struct job_t *job;

    if (sigfillset(&mask_all) < 0)
        sio_error("Sigfillset error");

    /* Reap zombie children including background process */
    while ((pid = waitpid (-1, &status, WNOHANG | WUNTRACED)) > 0) {     
           
        /* Block all signals before accessing global data structure */
        if (sigprocmask (SIG_BLOCK, &mask_all, &prev_all) < 0)
            sio_error ("Sigprocmask error");

        if ((job = getjobpid(jobs, pid)) == NULL)
            sio_error ("Getjobpid error in sigchld_handler");
 
        if (WIFEXITED(status))
            deletejob(jobs, pid);
        else if (WIFSIGNALED(status)) {
            printf("Job [%d] (%d) terminated by signal %d\n", job->jid, pid, WTERMSIG(status));
            deletejob(jobs, pid);
        } else if (WIFSTOPPED(status)) {
            printf("Job [%d] (%d) stopped by signal %d\n", job->jid, pid, WSTOPSIG(status));
            job->state = ST;
        }

        /* Restore blocked set */
        if (sigprocmask (SIG_SETMASK, &prev_all, NULL) < 0)
            sio_error ("Sigprocmask error");
    }
    if (pid == -1 && errno != ECHILD)
        sio_error ("waitpid error");

    errno = olderrno;               /* Restore errno */
    return;
}
```

### 6. 함수 sigint_handler 구현하기
[ ✔️ ] 사용자가 ctrl-c 를 입력하면 `./tsh`는 `SIGINT` 시그널을 캐치해서 적절한 foreground job에게 포워딩한다.

```C
void sigint_handler(int sig) 
{
    pid_t pid;
    sigset_t mask_all, prev_all;

    if (sigfillset(&mask_all) < 0)
        sio_error ("Sigaddset error");

    /* Block all signals before accessing global data structure */
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0)
        sio_error("Sigprocmask error");

    /* If there is no foreground job, just return */
    if ((pid = fgpid(jobs)) <= 0) {
        /* Restore blocked set */
        if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0)
            sio_error("Sigprocmask error");
        return;
    }
    
    /* Forward signal to foreground job */
    if (kill(-pid, sig) < 0)
        sio_error ("Kill error");
    
    /* Restore blocked set */
    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0)
        sio_error("Sigprocmask error");
        
    return;
}
```

### 7. 함수 sigtstp_handler 구현하기

[ ✔️ ] 사용자가 ctrl-z 을 입력하면 `./tsh`는 `SIGTSTP` 시그널을 캐치해서 적절한 foreground job에게 포워딩한다.

```C
void sigtstp_handler(int sig) 
{
    pid_t pid;
    sigset_t mask_all, prev_all;

    if (sigfillset(&mask_all) < 0)
        sio_error ("Sigaddset error");

    /* Block all signals before accessing global data structure */
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0)
        sio_error("Sigprocmask error");

    /* If there is no foreground job, just return */
    if ((pid = fgpid(jobs)) <= 0) {
        if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0)
            sio_error("Sigprocmask error");
        return;
    }

    /* Forward signal to foreground job */
    if (kill(-pid, sig) < 0)
        sio_error ("Kill error");
    
    /* Restore blocked set */
    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0)
        sio_error("Sigprocmask error");
    
    return;
}
```

## What I Learned
- 키보드 입력과 같은 비동기 이벤트를 애플리케이션 레벨에서 시그널 catch를 통해 핸들링하기
- 동시성 버그를 예방할 수 있는 안전한 시그널 핸들링 함수 작성하기
- 디테일하게 예외 처리하기
- make 도구를 사용하여 빌드, 테스트 자동화하기

> ### 관련 포스팅
> - CS:APP 8장 원서 번역  
>   [(1) Exception](https://manythreedays.tistory.com/139) / [(2) Process](https://manythreedays.tistory.com/140) / [(3) Process Control](https://manythreedays.tistory.com/141) / [(4) Signal, Nonlocal Jump](https://manythreedays.tistory.com/142)
> - [[CMU-LAB] Unix Shell Lab 과제 안내서 번역](https://manythreedays.tistory.com/144)
> - [[CMU_LAB] Unix Shell Lab 리뷰](https://manythreedays.tistory.com/147)
> - [make로 빌드와 테스트 자동화하기](https://manythreedays.tistory.com/146)

## 과제물의 README

```
################
CS:APP Shell Lab
################

Files:

Makefile	# Compiles your shell program and runs the tests
README		# This file
tsh.c		# The shell program that you will write and hand in
tshref		# The reference shell binary.

# The remaining files are used to test your shell
sdriver.pl	# The trace-driven shell driver
trace*.txt	# The 15 trace files that control the shell driver
tshref.out 	# Example output of the reference shell on all 15 traces

# Little C programs that are called by the trace files
myspin.c	# Takes argument <n> and spins for <n> seconds
mysplit.c	# Forks a child that spins for <n> seconds
mystop.c        # Spins for <n> seconds and sends SIGTSTP to itself
myint.c         # Spins for <n> seconds and sends SIGINT to itself
```
