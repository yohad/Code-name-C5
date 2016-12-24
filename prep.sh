cp ./bin/$1.com ./corewars_engine/survivors/$1
cd corewars_engine
java -cp ./lib/corewars8086-4.0.1.jar il.co.codeguru.corewars8086.CoreWarsEngine
