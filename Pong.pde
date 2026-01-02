// Variável para controlar o fim do jogo
boolean gameOver = false;

//Variáveis para o posicionamento da bola int ballX, bally;

int ballX, ballY;
int ballSize = 10;
int ballSpeedX = 3;
int ballSpeedY = 3;

//Variáveis para o posicionamento das palhetas do jogador int playerPaddleX, playerPaddleY;

int playerPaddleX, playerPaddleY;
int playerWidth = 10;
int playerHeight = 40;
int playerSpeedY = 0;

//Variáveis para o posicionamento das palhetas do adversário int cuPaddleX, cuPaddleY;

int cpuPaddleX,cpuPaddleY;
int cpuWidth = 10;
int cpuHeight = 100;
int cpuSpeedY = 0;

//Variáveis para marcar a pontuação int scorePlayer; int scoreCPU;

int scorePlayer;
int scoreCPU;

//Função de inicialização 

void setup()
{

//Determinar o tamanho e a cor de fundo da tela

size(640, 360);
background(0,128,0);

//Atribui posição inicial da bola

ballX = width / 2;
ballY = height / 2;

//Atribui posição inicial da palheta do jogador

playerPaddleX = 10;
playerPaddleY = height / 2 - 50;

//Atribuir posição inicial da palheta do adversário

cpuPaddleX = width - 20;
cpuPaddleY = height/2 - 50;

//Determina o tamanho da fonte do texto

textSize(32);
setDifficulty("medium");
}

//Função de repetição 

void draw()
{ if (!gameOver) {
background(0,128,0);

//Chamadas de função para execução do jogo

score();
ballMovement();
cpuPaddle();
playerPaddle();
checkScore();
checkWinner();
}
}

//Função da movimentação da bola

void ballMovement() {

//Atualização da posição da bola

ballX = ballX + ballSpeedX;
ballY = ballY + ballSpeedY;

//Verificação da colisão da bola com as extremidades laterais

if (ballX > width) {
ballX = width / 2;
ballY = height / 2;
ballSpeedX = ballSpeedX * -1;
scorePlayer += 1;
}
if (ballX < 0) {
ballX = width / 2;
ballY = height / 2;
ballSpeedX = ballSpeedX * -1;
scoreCPU += 1;
}

//Verificação da colisão da bola com as extremidades superior e inferior da tela

if (ballY > height) {
ballY = height - ballSize / 2;
ballSpeedY = ballSpeedY * -1;
}
if (ballY < 0) {
ballY = ballSize / 2;
ballSpeedY = ballSpeedY * -1;
}

// Verificação da colisão da bola com a palheta do jogador

if ((ballY + ballSize / 2 >= playerPaddleY && ballY - ballSize / 2<= playerPaddleY + playerHeight) &&
(ballX + ballSize / 2 >= playerPaddleX && ballX - ballSize / 2 <= playerPaddleX +
playerWidth)) {
ballSpeedX = ballSpeedX * -1;
ballX = ballSize / 2 + playerPaddleX + playerWidth;
}

// Verificação da colisão da bola com a palheta do adversário

if ((ballY + ballSize / 2>= cpuPaddleY && ballY - ballSize / 2 <= cpuPaddleY + cpuHeight) &&
(ballX + ballSize / 2 >= cpuPaddleX && ballX - ballSize / 2 <= cpuPaddleX + cpuWidth)) {
ballSpeedX = ballSpeedX * -1;
ballX = cpuPaddleX - ballSize / 2;
}
noStroke();
fill(0);
ellipse(ballX, ballY, ballSize, ballSize);
}

//Função da palheta do adversário

void cpuPaddle() {
cpuPaddleY = cpuPaddleY + cpuSpeedY;

//Criação do comportamento da palheta inimiga
if (ballX > width / 2) {
if (ballY - ballSize > cpuPaddleY + cpuHeight / 2) {
cpuSpeedY = 2;
} else if (ballY + ballSize < cpuPaddleY + cpuHeight / 2) {
cpuSpeedY = -2;
}else {
cpuSpeedY = 0;
}
} else {
cpuSpeedY = 0;
}

//Limitação dos movimentos da palheta dentro do espaço da tela

if (cpuPaddleY + cpuHeight > height) {
cpuPaddleY = height - cpuHeight;
}
if (cpuPaddleY < 0) {
cpuPaddleY = 0;
}
fill(0, 0, 255);
rect(cpuPaddleX, cpuPaddleY, cpuWidth, cpuHeight);
}

//Função da palheta do jogador

void playerPaddle() {
playerPaddleY = playerPaddleY + playerSpeedY;

//Limitação dos movimentos da palheta dentro do espaço da tela

if (playerPaddleY + playerHeight > height) {
playerPaddleY = height - playerHeight;
}
if (playerPaddleY < 0) {
playerPaddleY = 0;
}
fill(0,255,127);
rect(playerPaddleX, playerPaddleY, playerWidth, playerHeight);
}

//Exibe o placar

void score(){
  text(scorePlayer,160, 50);
  text(scoreCPU, 480, 50);
}

//Verificação do pressionamento dos botões para movimentação da palheta do jogador

void keyPressed(){
  if(key == 's' || key == 'S'){
    playerSpeedY = 5;
  }
  if(key == 'w' || key == 'W'){
    playerSpeedY = -5;
  }
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}

//Verificação o soltar dos botões para movmetação da palheta do jogador 

void keyReleased(){
  if(key == 's' || key == 'S' || key == 'w' || key == 'W'){
    playerSpeedY = 0;
  }
}

int WINNING_SCORE = 10;

void checkWinner() {
  if (scorePlayer >= WINNING_SCORE) {
    displayWinner("Player");
    gameOver = true;
  } else if (scoreCPU >= WINNING_SCORE) {
    displayWinner("CPU");
    gameOver = true;
  }
}

void displayWinner(String winner) {
  background(0);
  textAlign(CENTER);
  textSize(32);
  fill(255);
  text(winner + " wins!", width / 2, height / 2);
  textSize(20);
  text("Aperte R para recomeçar a jogar", width / 2, height / 2 + 40);
  noLoop(); 
  delay(3000);
  resetGame();
}

void resetGame() {
  scorePlayer = 0;
  scoreCPU = 0;
  gameOver = false;
  ballX = width / 2;
  ballY = height / 2;
  playerPaddleY = height / 2 - playerHeight / 2;
  cpuPaddleY = height / 2 - cpuHeight / 2;
  loop(); 
}

void setDifficulty(String level) {
  switch(level) {
    case "easy":
      playerHeight = 60;
      cpuHeight = 60;
      cpuSpeedY = 4;
      ballSpeedX = 4;
      ballSpeedY = 4;
      break;
    case "medium":
      playerHeight = 40;
      cpuHeight = 40;
      cpuSpeedY = 5;
      ballSpeedX = 5;
      ballSpeedY = 5;
      break;
    case "hard":
      playerHeight = 25;
      cpuHeight = 25;
      cpuSpeedY = 6;
      ballSpeedX = 5;
      ballSpeedY = 5;
      break;
  }
}

void checkScore() {
  checkWinner();
  text(scorePlayer, 160, 50);
  text(scoreCPU, 480, 50);
}
