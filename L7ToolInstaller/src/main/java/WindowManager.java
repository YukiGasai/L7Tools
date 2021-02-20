import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class WindowManager extends JFrame {

    public WindowManager() {
        super("L7Tool Installer");

        setSize(300,500);
        setVisible(true);
        setLayout(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        JButton start = new JButton();
        start.setBounds(20,20,100,20);
        start.setText("Install");
        start.setVisible(true);
        start.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.out.println("TEST");
            }
        });

        add(start);


    }




}
