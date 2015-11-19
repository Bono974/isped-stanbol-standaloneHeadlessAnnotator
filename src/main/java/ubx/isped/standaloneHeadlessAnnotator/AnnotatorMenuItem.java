package ubx.isped.standaloneHeadlessAnnotator;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;
import org.apache.stanbol.commons.web.base.NavigationLink;


@Component
@Service(NavigationLink.class)
public class AnnotatorMenuItem extends NavigationLink {
    
    public AnnotatorMenuItem() {
        super("headlessAnnotator", "Standalone Headless Annotator", "Standalone Headless Annotator endpoint service", 300);
    }
    
}
