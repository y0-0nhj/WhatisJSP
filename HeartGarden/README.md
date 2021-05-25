# My First ShoppingMall JSP Project


> ### 프로그램의 기술적 목적

- 쇼핑몰 웹개발은 웹프로그래밍의 필요한 구조를 갖고 있다.
- 쇼핑몰은 웹개발은 관리자 페이지 상품관리 등록 , 수정 , 삭제 ), 상품 목록 조회 , 상품 상세 보기 , 회원 관리 , 세션 기능 , 장바구니 , 주문 내역 관리 , 문의 내역 게시판 글쓰기 (Insert), 글목록과 글내용보기 (Select), 글수정 (Update), 글삭제 Delete)) 라는 웹프로그래밍의 기본구조 패턴을 가지고 있다.
- 이러한 쇼핑몰의 구조를 이해하게 되면 , 어떠한 웹 애플리케이션을 개발하게 되더라도 해결할 수 있는 능력을 갖게 된다.
<br>

> ### 프로그램의 주요 기술

- HTML5 CSS3 Javascript 사용
-  JSP 기본 스크립트 요소 사용 scriptlet , expression
-  JSP 내장 객체 사용
- JavaBean 과 액션 태그 사용
- JDBC 와 Connection Pool 사용
- MySQL DBMS 사용
- 댓글 처리 기능 구현
- 페이징 처리 기능 구현
<br>

> ### 프로그램의 활용 장비 및 제작 기간

-  개발 프로그래밍 : jdk 8u271 windows x64
-  통합개발도구 : eclipse jee 2020 06 R win32 x86_64
-  DB Server : mysql installer community 8.0.22.0
-  WAS Server : apache tomcat 9.0.41
-  CP : Apache Commons Connection Pool
-  Web Browser : Chrome
-  제작 소요 기간 : 2달
<br>



> ### 쇼핑몰의 주제

![image](https://user-images.githubusercontent.com/69184843/119449141-38fb2480-bd6d-11eb-9265-385fea686cb3.png)

<br>

> ### 전체 구성도 (화면 흐름도 & ERD 조식도 & Service Process)

화면 흐름도

![image](https://user-images.githubusercontent.com/69184843/119457153-54b6f880-bd76-11eb-82c2-91c2790ba697.png)


ERD 조식도 및 Service Process

![image](https://user-images.githubusercontent.com/69184843/119457256-71533080-bd76-11eb-9974-2f976dd3eaa8.png)

<br>
<br>

> ### 쇼핑몰 프로젝트 구성

![image](https://user-images.githubusercontent.com/69184843/119457639-dc046c00-bd76-11eb-8778-87b51cbaa046.png)

<br>

> ### 쇼핑몰 홈페이지 실행 영상

Main 화면



![녹화_2021_05_25_16_09_38_566](https://user-images.githubusercontent.com/69184843/119455463-9777d100-bd74-11eb-904e-c96b2ba09658.gif)


Menu별 전체보기 목록

![녹화_2021_05_25_16_11_32_8](https://user-images.githubusercontent.com/69184843/119455457-9646a400-bd74-11eb-9abb-7539c09bac50.gif)


상품 상세보기 화면


![녹화_2021_05_25_16_12_25_303](https://user-images.githubusercontent.com/69184843/119455441-92b31d00-bd74-11eb-9da6-4e29f56bcca1.gif)


로그인, 장바구니/주문목록 화면

![녹화_2021_05_25_16_13_40_510](https://user-images.githubusercontent.com/69184843/119455624-bbd3ad80-bd74-11eb-8466-58c2e3d8afc6.gif)

<br>

> ### 관리자 홈페이지 실행 영상

![녹화_2021_05_25_16_40_57_633](https://user-images.githubusercontent.com/69184843/119459004-4538af00-bd78-11eb-9238-30710fd51dd5.gif)

<br>

> ### 향후 개선 사항

1. 쇼핑몰을 효율적인 구조로 개발할 수 있도록 Spring Framework 로 개발한다.
2. DBBean (DAO) 에서 메소드의 중복되는 부분을 없애도록 수정한다.
3. JSP 와 HTML 코드를 분리시켜 작업하도록 수정한다.
4. 계좌나 카드 결제 시스템 모듈을 적용하여 사용자가 편리하게 접근할 수 있도록 개선한다.
5. 관리자 페이지에 구매 목록을 조회할 수 있는 기능을 추가 & 쇼핑몰 내 자체에서 관리자 접속과 회원 접속이 가능하도록 기능을 개선한다.
6. 상품 분류 작업과 검색 기능을 개선한다.

<br>

> ### 프로젝트 후기
1. DB 설계 , HTML 설계 , JAVA 와 JSP 를 활용하여 웹개발의 전반적인 흐름을 파악할 수 있었습니다.
2. 관리자 페이지 설계 및 개발 , 상품 등록 및 관리 페이지 설계 및 개발 , 회원가입 , 로그인 등의 회원 페이지 설계 및 개발 , 장바구니 , 주문 , 결제 목록 등의 주문 결제 페이지 설계 및 개발을 하며 웹애플리케이션에서 CRUD 를 구현할 수 있었습니다.
3. JDBC 와 Apache Commons Connection Pool 을 사용하여 DB 와의 효율로 연결하였습니다.
4. 세션 , 액션태그 등을 활용하여 웹에서의 데이터의 이동과 연결에 대해서 이해하고 활용할 수 있었습니다.
5. 두 달이라는 짧은 기간동안 만들어진 프로젝트라 부족하고 단순한 기능 구현을 우선으로 했지만 웹 개발의 전체적인 과정을 익혔습니다 . 향후 응용된 기술을 구현할 계획입니다.

<br>


> ### 쇼핑몰 프로젝트 제작에 도움을 주었던 샵이나 이미지 출처
https://smartstore.naver.com/pulddegi
https://smartstore.naver.com/plant_mk
http://www.cultwo-flower.com/?NaPm=ct%3Dkp3rb32u%7Cci%3Dcheckout%7Ctr%3Dds%7Ctrx%3D%7Chk%3Da2d3e02390cd8d3237a8fec97fb0f5eec559f835

꽃 종류 이미지 Googling
https://www.google.com/search?sxsrf=ALeKk01j9aVLBIUmJyvwgy9SgH3FW4L5vQ:1621930138739&source=univ&tbm=isch&q=%EC%88%98%EB%A0%88%EA%B5%AD%ED%99%94&sa=X&ved=2ahUKEwj2h5TOsOTwAhUGqpQKHT1oA5AQjJkEegQIBRAB&biw=1552&bih=870
https://www.google.com/search?q=%EA%B5%AD%ED%99%94&tbm=isch&ved=2ahUKEwju5qbQsOTwAhVCWpQKHcNhAHgQ2-cCegQIABAA&oq=%EA%B5%AD%ED%99%94&gs_lcp=CgNpbWcQAzIECCMQJzIECCMQJzICCAAyAggAMgIIADICCAAyAggAMgIIADICCAAyAggAUKNfWKNfYLZgaABwAHgAgAFoiAFokgEDMC4xmAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=n7CsYK6bDsK00QTDw4HABw&bih=870&biw=1552
https://www.google.com/search?q=%EB%B0%B1%ED%95%A9&tbm=isch&ved=2ahUKEwj4u_PWsOTwAhWXx4sBHT4NCFMQ2-cCegQIABAA&oq=%EB%B0%B1%ED%95%A9&gs_lcp=CgNpbWcQAzIECCMQJzIECCMQJzICCAAyAggAMgIIADICCAAyAggAMgIIADICCAAyAggAOgUIABCxA1CVWFikW2CuXGgAcAB4AIABdIgBmQWSAQMwLjaYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=rbCsYLixBJePr7wPvpqgmAU&bih=870&biw=1552
