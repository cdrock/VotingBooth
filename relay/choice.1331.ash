script "Vote Pictures";
notify cdrock;

import "relay/choice.ash";

void main(string page_text_encoded)
{
	string page_text = page_text_encoded.choiceOverrideDecodePageText();
	string [string] form_fields = form_fields();
	
	string[string] fields = form_fields();
	
	string mutantImage = "<img src='http://cdn.coldfront.net/thekolwiki/images/2/24/Vwmutant.gif'>";
	string ghostImage = "<img src='http://cdn.coldfront.net/thekolwiki/images/c/ce/Vw_ghost.gif'>";
	string snakeImage = "<img src='http://cdn.coldfront.net/thekolwiki/images/d/da/Vwsnake.gif'>";
	string blobImage = "<img src='http://cdn.coldfront.net/thekolwiki/images/a/a6/Vwslime.gif'>";
	string bureaucratImage = "<img src='http://cdn.coldfront.net/thekolwiki/images/a/ae/Vwgovt.gif'>";
	
	matcher voterText = create_matcher("<blockquote>.*?</blockquote>", page_text);
	
	while (find(voterText)){
      string text = group(voterText, 0);
	  
	  string imageText = "";
	  if(
		contains_text(text, "In order to really")
		|| contains_text(text, "Physical health")
		|| contains_text(text, "A government")
		|| contains_text(text, "It's come")
		|| contains_text(text, "As you know")
	  ) {
		imageText = bureaucratImage;
	  } else if (
		contains_text(text, "In order to promote")
		|| contains_text(text, "You humans are")
		|| contains_text(text, "Distribution of")
		|| contains_text(text, "In order to increase")
		|| contains_text(text, "It has come to")
	  ) {
		imageText = mutantImage;
	  } else if (
		contains_text(text, "In order to confirm")
		|| contains_text(text, "Vouldn't you like to see")
		|| contains_text(text, "I don't think I need")
		|| contains_text(text, "Once elected, I")
		|| contains_text(text, "To better prepare your")
	  ) {
		imageText = ghostImage;
	  } else if (
		contains_text(text, "We're still")
		|| contains_text(text, "Some have called")
		|| contains_text(text, "In order to reduce the federal")
		|| contains_text(text, "To better prepare our environment for")
		|| contains_text(text, "The fuel my people use")
	  ) {
		imageText = blobImage;
	  } else if (
		contains_text(text, "One thing that's pretty clear")
		|| contains_text(text, "Everyone says ve vampires are")
		|| contains_text(text, "Our Animal Inspection Committee")
		|| contains_text(text, "The Book of Smiling Teeth")
		|| contains_text(text, "It has recently come to my attention")
	  ) {
		imageText = snakeImage;
	  }
	  
	  page_text = replace_string(page_text, text, "<div style='display:flex;align-items:center;padding-left:40px'>"+imageText+text+"</div>");
	}
	
	write(page_text);
}