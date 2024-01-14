MODULE Module1
	CONST jointtarget home:=[[1.04346,0,0,0,30,-5.57934E-7],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	CONST robtarget p10:=[[-31.85,-928.07,1412.50],[0.347437,0.622786,0.601778,-0.359566],[-2,0,-1,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    VAR socketdev priza_server;
    VAR socketdev priza_client;
    VAR string adresa_ip;
    VAR string mesaj_de_la_client;
    VAR string comparator;
    VAR string adresa_ip_computer:="127.0.0.1";
    VAR num numar_port:=1025;
    
    PROC main()
        !MoveAbsJ home\NoEOffs, v1000, z50, tool0;
        !MoveJ p10, v1000, z50, tool0;
        adresa_ip_computer:="127.0.0.1";
        SocketCreate priza_server;
        SocketBind priza_server,adresa_ip_computer,numar_port;
        SocketListen priza_server;
        WHILE TRUE DO
            SocketAccept priza_server,priza_client\ClientAddress:=adresa_ip\Time:=30;
            SocketReceive priza_client\Str:=mesaj_de_la_client;
            TPWrite mesaj_de_la_client;
            comparator:=mesaj_de_la_client;
            TEST comparator
            CASE "aplicatia_1":
                SocketSend priza_client\Str:="go"+"";
                MoveJ p10, v1000, z50, tool0;
                WaitTime 1;
                MoveAbsJ home\NoEOffs, v1000, z50, tool0;
                SocketClose priza_client;
            DEFAULT:
                TPWrite "Nicio aplicatie";
                SocketSend priza_client\Str:="Am lansat parcarea"+"";
                MoveAbsJ home\NoEOffs, v1000, z50, tool0;
                SocketClose priza_client;
            ENDTEST
            TPErase;
        ENDWHILE
        
        ERROR
            RETRY;
        UNDO
        SocketClose priza_server;
        SocketClose priza_client;
    ENDPROC
ENDMODULE