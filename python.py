import socket
import sys


def trimitere_primire_mesaje():
    adresa_serverului = ("127.0.0.1", 1025)
    print (sys.stderr, "Conectare la adresa %s si portul %s" % adresa_serverului)
    priza_ethernet = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    priza_ethernet.connect(adresa_serverului)
    print ("Orice alt mesaj va duce robotul in pozitia de parcare")
    mesajul_introdus="aplicatia_1".encode()
    if mesajul_introdus == b"aplicatia_1":
        print ("Ai ales prima aplicatie")
        print (sys.stderr, "Se va trimite mesajul %s" % mesajul_introdus)
        priza_ethernet.sendall(mesajul_introdus)
        mesaj_primit = repr(priza_ethernet.recv(1025))
        print("--------------"+mesaj_primit)
        if mesaj_primit.find("go"):
            adresa_serverului = ("127.0.0.2", 1025)
            print (sys.stderr, "Conectare la adresa %s si portul %s" % adresa_serverului)
            priza_ethernet = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            priza_ethernet.connect(adresa_serverului)
            print ("Orice alt mesaj va duce robotul in pozitia de parcare")
            mesajul_introdus="222".encode()
            if(mesajul_introdus==b"222"):
                print ("Ai ales prima aplicatie")
                print (sys.stderr, "Se va trimite mesajul %s" % mesajul_introdus)
                priza_ethernet.sendall(mesajul_introdus)
                mesaj_primit = repr(priza_ethernet.recv(1025))
        



i=0
while True:

    trimitere_primire_mesaje()
    i=i+1
    print ("Ai incheiat ciclul" + str(i))

priza_ethernet.close()
