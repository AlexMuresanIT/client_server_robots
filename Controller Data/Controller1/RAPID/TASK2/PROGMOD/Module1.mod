MODULE Module1
	CONST jointtarget home1:=[[1.67378,0,0,0,30,-5.57934E-7],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	CONST robtarget p11:=[[3149.41,928.58,1412.50],[0.354918,-0.609999,0.614737,0.352183],[-2,0,-1,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
     VAR socketdev priza_servera;
    VAR socketdev priza_clienta;
    VAR string adresa_ipa;
    VAR string mesaj_de_la_clienta;
    VAR string comparatora;
    VAR string adresa_ip_computera:="127.0.0.2";
    VAR num numar_porta:=1025;
    
    PROC main()
        !MoveAbsJ home1\NoEOffs, v1000, z50, tool0;
        !MoveJ p11, v1000, z50, tool0;
        adresa_ip_computera:="127.0.0.2";
        SocketCreate priza_servera;
        SocketBind priza_servera,adresa_ip_computera,numar_porta;
        SocketListen priza_servera;
        WHILE TRUE DO
            SocketAccept priza_servera,priza_clienta\ClientAddress:=adresa_ipa\Time:=30;
            SocketReceive priza_clienta\Str:=mesaj_de_la_clienta;
            TPWrite mesaj_de_la_clienta;
            comparatora:=mesaj_de_la_clienta;
            TEST comparatora
            CASE "222":
                SocketSend priza_clienta\Str:="go"+"";
                MoveJ p11, v1000, z50, tool0;
                WaitTime 1;
                MoveAbsJ home1\NoEOffs, v1000, z50, tool0;
                SocketClose priza_clienta;
            DEFAULT:
                TPWrite "Nicio aplicatie";
                SocketSend priza_clienta\Str:="Am lansat parcarea"+"";
                MoveAbsJ home1\NoEOffs, v1000, z50, tool0;
                SocketClose priza_clienta;
            ENDTEST
            TPErase;
        ENDWHILE
        
        ERROR
            RETRY;
        UNDO
        SocketClose priza_servera;
        SocketClose priza_clienta;
    ENDPROC
ENDMODULE