{**
 * plugins/themes/ukweli/templates/frontend/objects/article_summary.tpl
 *
 * Ukweli modern card-based article summary template override.
 *}
{assign var=publication value=$article->getCurrentPublication()}
{assign var=articlePath value=$publication->getData('urlPath')|default:$article->getId()}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}

<article class="obj_article_summary ukweli-card">
	<div class="ukweli-card-header">
		<span class="ukweli-badge peer-reviewed">{translate key="section.default"}</span>
		{if $showDatePublished && $publication->getData('datePublished')}
			<span class="ukweli-card-date">{$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
		{/if}
	</div>

	{if $publication->getLocalizedData('coverImage')}
		<div class="cover">
			<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="file">
				{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
				<img
					src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
					alt="{$coverImage.altText|escape|default:''}"
				>
			</a>
		</div>
	{/if}

	<{$heading} class="ukweli-card-title title">
		<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
			{$publication->getLocalizedTitle()|strip_unsafe_html}
		</a>
	</{$heading}>

	{if $publication->getData('authors')}
		<div class="ukweli-card-authors authors">
			{$publication->getAuthorString($authorUserGroups)|escape}
		</div>
	{/if}

	{if $publication->getLocalizedData('abstract')}
		<div class="ukweli-card-abstract">
			{$publication->getLocalizedData('abstract')|strip_tags|truncate:200:"..."}
		</div>
	{/if}

	{if !$hideGalleys && $publication->getData('galleys')}
		<div class="ukweli-card-footer galleys_links">
			{foreach from=$publication->getData('galleys') item=galley}
				{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasAccess}
			{/foreach}
		</div>
	{/if}
</article>
