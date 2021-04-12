# Connect Four
어셈블리어로 구현한 입체사목 보드게임 프로젝트
<br><br>
### 프로젝트 설명
입체 사목 게임이라는 보드 게임을 어셈블리어로 구현한 프로그램이다. 게임 방식은 기존의 오목과 비슷하나 이 게임의 경우 사목판이 바닥과 수직으로 세워져 있기 때문에 원하는 세로줄의 맨 위에서부터 돌을 넣으면 해당 줄의 맨 아래칸부터 돌이 채워지게 된다. 이렇게 밑에서부터 돌을 쌓는 형식으로 진행이 되며 같은 색의 돌이 가로 / 세로 / 대각선으로 연속해서 4개가 놓여지게 되면 해당 돌의 플레이어가 승리한다.
<br>
### 구현 환경
- 개발 환경 : Visual Studio
- 언어 : Assembly language

### 프로젝트 Demo 영상
{% include demo.html id="UxGk0kONDYs" %} 
<br><br>
## 상세 개발 과정
<dl>
1. 사목판 구현
  <dd> 사목판의 각 칸은 x, y좌표값과 칸의 상태(비어 있는 경우 · 흑돌이 놓여진 경우 · 백돌이 놓여진 경우)를 가지고 있는 구조체로 구현된다. 6X7 크기의 판을 구현하기 위해 총 42개의 구조체 배열을 선언하였다.</dd>
2. 구조체 초기화
  <dd> 구조체로 구현된 사목판의 각 칸들을 초기화 해주는 Init 프로시저를 정의하여 사용하였다. 각 칸 별로 사목판의 형태에 맞게 출력될 수 있도록 x, y 좌표를 넣어주었고 게임 시작 전에는 모든 칸이 비어 있으므로 각 칸의 상태를 비어 있는 상태로 초기화해주었다. 판의 크기가 6X7이므로 중첩된 반복분을 사용하여 바깥쪽에 있는 반복문 6번 반복, 안쪽에 있는 반복문 7번 반복으로 총 42개의 구조체를 초기화해주었다.</dd>
3. 사목판 화면 출력
  <dd> 사목판의 상태를 화면에 출력해주는 print 프로시저를 정의하여 사용하였다. 반복문을 이용하여 구조체 배열의 첫번째 구조체부터 x, y값을 dl, dh에 넣어준 뒤 call gotoxy 라이브러리 프로시저로 커서 이동 후 각 칸의 상태에 맞는 문자를 화면에 출력해주었다. 각 칸의 상태는 비어 있는 경우 X, 흑돌이 들어간 경우 ●, 백돌이 들어간 경우 ○로 출력된다.</dd>
4. 입력받은 위치에 돌 삽입
  <dd> 알맞은 위치에 돌을 삽입하는 inputStone 프로시저를 정의하여 사용하였다. 입력된 돌의 상태(흑돌 / 백돌)를 ebx에 들어있는 값으로 구분한 뒤 해당 상태의 돌을 입력 받은 위치의 칸들 중 비어 있는 가장 아래칸에 넣어주었다. 위치값은 eax로 받았으며 만약 입력 받은 값이 구조체 배열의 OFFSET 범위를 벗어난 경우 안내문 출력 후 다시 입력 받았다. 입력 받은 위치의 칸들 중 가장 아래칸부터 상태를 검사하여 비어 있는 칸일 경우 돌을 넣어주었고, 맨 위칸까지 검사하고 나서도 비어 있는 칸이 없는 경우 해당 줄에는 더 이상 넣을 수 없다는 안내문 출력 후 입력을 다시 받았다. 정상적인 입력일 경우 돌이 들어갈 구조체의 칸의 상태를 해당 돌의 색깔에 맞게 바꿔주고 사목판을 다시 출력하였다.</dd>
5. 게임 종료  
  <dd> checkStone 프로시저를 사용하여 돌이 입력될 때마다 입력된 돌을 기준으로 주변 칸들의 상태를 검사하여 게임이 종료되는 경우를 판별하였다. 게임이 종료되는 경우는 사목판이 다 채워진 경우와 흑돌과 백돌이 각각 가로 · 세로 · 대각선(왼쪽위-오른쪽아래 방향 · 오른쪽위-왼쪽아래 방향)으로 연속해서 돌이 4개이상 놓여진 경우로 나누었다. 가로의 경우 놓여진 돌 기준 왼쪽 돌이 놓여진 돌과 같은 색일 경우 ecx에 저장된 카운터 값을 1 증가시켜주었다. 이 과정을 반복문을 통해 비어 있는 칸이 나오거나 놓여진 돌과 다른 색의 돌이 놓여진 칸이 나올 때까지 왼쪽으로 계속 반복해주었다. 가로 방향은 놓여진 돌 기준 오른쪽에 놓인 돌들도 포함이므로 같은 과정을 오른쪽 방향으로도 진행해주었고, 반복문이 끝난 후 ecx값을 비교하여 3보다 큰 경우 4개의 같은 돌이 연속해서 놓여졌으므로 해당 돌의 플레이어의 승리로 게임을 끝냈다. 세로 · 대각선(왼쪽위-오른쪽아래 방향 · 오른쪽위-왼쪽아래 방향)으로 조건을 만족한 경우도 이와 같은 방식으로 판별해냈다.
   사목판이 돌로 다 채워져서 게임이 끝난 경우는 IF문을 이용해 사목판의 맨 윗줄에 있는 7개의 칸이 모두 채워졌을 경우를 판별하여 게임을 종료하였다. 사목판이 모두 채워져서 게임이 종료된 경우에는 플레이어에게 게임 재시작 여부를 물어보며 1을 입력 받으면 구조체 배열 초기화부터 시작해 main 프로시저를 다시 반복하여 주었고, 0을 입력 받으면 그대로 프로그램을 끝냈다. </dd>
6. main 프로시저
  <dd> 프로그램이 시작되면 먼저 구조체 배열을 초기화 해준 뒤 정해진 위치에 타이틀, 사목판, 차례, 위치입력 안내문을 출력하였다. 돌을 입력 받을 때마다 inputStone 프로시저와 checkStone 프로시저를 실행하여 게임 진행 상태를 판별하며 돌이 정상적으로 입력되고 게임이 끝나지 않은 경우 jmp를 이용하여 타이틀 출력부터 반복하여 주었다. </dd>
</dl>
