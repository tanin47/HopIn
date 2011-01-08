function validate_input_obj(input_obj,fn,value)
{
	if (value == null){
		value = $(input_obj).val();
	}
	
	var error = fn(value);
			
	if ((!(error instanceof Array) && error != null) 
		|| (error instanceof Array && error.length > 0))
	{
		$(input_obj).ruby_error(error,true);
		return false;
	}
	else
	{
		$(input_obj).ruby_error(error,false);
		return true;
	}
}

function get_string_errors(s)
{
	if( s.trim().length <= 0 )
	{
		return "Cannot be empty";
	}
	if( s.trim().length > 255 )
	{
		return "Cannot contain more than 255 characters";
	}
	return null;
}

function get_money_errors(s)
{
	if( s.trim().length <= 0 )
	{
		return "Cannot be empty";
	}
	
	if (!(s.trim().match(/^[0-9]+(\.[0-9]{1,2})?$/)))
	{
		return "Must be a number with at most two decimal point"
	}
	
	return null;
}

function get_number_errors(s)
{
	if( s.trim().length <= 0 )
	{
		return "Cannot be empty";
	}
	
	if (!(s.trim().match(/^[0-9]+?$/)))
	{
		return "Must be a number"
	}
	
	return null;
}

function get_email_errors(s)
{
	// check empty
	if( s.length <= 0 )
	{
		return "Must be an email";
	}
	// check invalid format
	index = s.indexOf( "@" );
	if( index == -1 )
	{
		return "is invalid because it does not contain '@'.";
	}
	// check min length
	mailaddr = s.substring(0, index);
	if( mailaddr.length < 4 )
	{
		return "is invalid because it must be at least 4 characters long";
	}
	// check max length
	if( mailaddr.length > 255 )
	{
		return "is invalid because it must be at most 255 characters long";
	}

	return null;
}

